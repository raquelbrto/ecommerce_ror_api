class ProcessBonusWorker
  include Sidekiq::Worker

  sidekiq_options queue: :process_bonus, backtrace: true, retry: true

  def self.perform(user_id, amount)
    FidelityClient.send_bonus(user_id, amount)
  rescue StandardError => e
    logger.error("Falha ao processar bônus para user_id: #{user_id}, amount: #{amount}. Erro: #{e.message}")
    raise e
  end
end
