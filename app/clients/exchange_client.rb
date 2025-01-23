class ExchangeClient
  def initialize
    @client = Faraday.new(url: ENV["EXCHANGE_API_URL"])
  end

  def exchange_rate(from:, to:)
    response = @client.get("")
    raise "Error getting exchange rate" unless response.status == 200
    JSON.parse(response.body) if response.status == 200
  end
end
