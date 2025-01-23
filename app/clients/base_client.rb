class BaseClient
  def initialize(base_url)
    Faraday.new(url: base_url)
  end
end
