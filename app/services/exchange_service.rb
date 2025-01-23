class ExchangeService
  def initialize
    @exchange_client = ExchangeClient.new
  end

  def self.perform
    @exchange_client.exchange_rate
    rescue => e
      Rails.logger.error("Error getting exchange rate: #{e.message}")
      fallback_exchange_rate
  end

  private

  def fallback_exchange_rate
  end
end
