require "oj"

class RabbitProducer
  include Sidekiq::Worker

  sidekiq_options queue: :process_transaction, backtrace: true, retry: true

  def perform(buffer)
    RABBITMQ_POOL.with do |channel|
      exchange = channel.fanout(ENV["EXCHANGE"], durable: true)
      buffer.each_slice(200).each do |posts|
        exchange.publish(
          Zlib::Deflate.deflate(Oj.dump(posts, mode: :compat)),
          persistent: true,
          content_type: "application/json"
        )
      end
      success = channel.wait_for_confirms

      handle_error(buffer) if not success

      Rails.logger.info "Sending #{Oj.dump(buffer, mode: :compat)} to rabbit"
    end
  end

  def publish(buffer)
    perform buffer
  end

  private

  def handle_error(buffer)
    Rails.logger.info "Erro no envio do rabbitmq, tentar novamente em 10 minutos"
    NotifyRabbit.perform_at(Time.now + 10.minutes, buffer)
  end
end
