class StoreService
  def initialize
    @store_client = StoreClient.new
    @store_cache = Cache.new
  end

  def create_sell(product_id)
    @store_client.create_sell(product_id)
    rescue => e
      Rails.logger.error("Error creating sell: #{e.message}")
      fallback_sell(product_id, e.message)
  end

  def get_product(product_id)
    product_details = @store_client.find_product(product_id)
    @store_cache.set("product_#{product_id}", product_details.to_s, 60)
    rescue => e
      Rails.logger.error("Error getting product: #{e.message}")
      fallback_product(product_id)
  end

  private

  def fallback_sell(product_id, message)
    Rails.logger.error("Error creating sell. Service store is down. Product ID: #{product_id}. Error: #{message}")
  end

  def fallback_product(product_id)
    product_details = @store_cache.get("product_#{product_id}")

    if product_details != null
      JSON.parse(product_details)
    else
      Rails.logger.error("Error getting product from cache")
    end
  end
end
