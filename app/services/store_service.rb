class StoreService
  def initialize
    @store_client = StoreClient.new
  end

  def create_sell(product_id)
    @store_client.create_sell(product_id)
    rescue => e
      Rails.logger.error("Error creating sell: #{e.message}")
      fallback_sell(product_id)
  end

  def get_product(product_id)
    @store_client.find_product(product_id)
    rescue => e
      Rails.logger.error("Error getting product: #{e.message}")
       fallback_product(product_id)
  end

  private

  def fallback_sell(product_id)
  end

  def fallback_product(product_id)
  end
end
