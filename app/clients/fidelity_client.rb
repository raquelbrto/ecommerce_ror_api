class FidelityClient
  def initialize
    @client = Faraday.new(url: ENV["FIDELITY_API_URL"])
  end

  def send_bonus(user_id, amount)
    response = @client.post("/bonus?userId=#{user_id}&bonus=#{amount}")
    raise "Error sending bonus" unless response.status == 200
    JSON.parse(response.body)
  end
end
