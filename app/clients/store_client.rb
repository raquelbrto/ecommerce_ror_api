class StoreClient
  def initialize
    @client = Faraday.new(url: ENV["STORE_API_URL"])
  end

  def create_sell(product_id)
    response = @client.post("/sell?productId=#{product_id}")
    raise "Error creating sell" unless response.status == 200
    JSON.parse(response.body)
  end

  def find_product(id)
    response = @client.get("/product/#{id}")
    raise "Error getting product" unless response.status == 200
    JSON.parse(response.body)
  end
end
