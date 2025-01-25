class SellService
  def initialize
    @store_client = StoreClient.new
    @store_cache = Cache.new
    @exchange_client = ExchangeClient.new
    @exchange_cache = Cache.new
    @fidelity_client = FidelityClient.new
    @store_service = StoreService.new
    @exchange_service = ExchangeService.new
    @fidelity_service = FidelityService.new
  end

  def process_sell(user_id, product_id, ft)
    if ft
      process_sell_ft(user_id, product_id)
    else
      process_sell_regular(user_id, product_id)
    end
  end

  def process_sell_ft(user_id, product_id)
    product = @store_service.get_product(product_id)
    @store_service.create_sell(product_id)
    exchange_rate = @exchange_service.get_exchange_rate
    total = conversion(exchange_rate, product["value"])
    transaction = @store_service.create_sell(product_id)
    @fidelity_service.send_bonus(user_id, total)

    transaction
  end

  def process_sell_regular(user_id, product_id)
    product = @store_client.find_product(product_id)
    exchange_rate = @exchange_client.exchange_rate
    total = conversion(exchange_rate, product["value"])
    transaction = @store_client.create_sell(product_id)
    @fidelity_client.send_bonus(user_id, total)

    transaction
  end

  private

  def conversion(rate, product_value)
    rate * product_value
  end
end
