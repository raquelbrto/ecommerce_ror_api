class ExchangeService
  def initialize
    @exchange_client = ExchangeClient.new
    @exchange_cache = Cache.new
  end

  def self.get_exchange_rate
    exchange_rate = @exchange_client.exchange_rate
    rate = exchange_rate["rate"]
    @exchange_cache.set("exchange_rate", rate.to_s, 60)

    exchange_rate
    rescue => e
      Rails.logger.error("Error getting exchange rate: #{e.message}")
      fallback_exchange_rate
  end

  private

  def fallback_exchange_rate
    rate = @exchange_cache.get("exchange_rate")

    if rate != null
      rate.to_f
    else
      Rails.logger.error("Error getting exchange rate from cache")
    end
  end
end
