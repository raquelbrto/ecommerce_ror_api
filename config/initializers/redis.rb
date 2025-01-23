REDIS_CACHE ||= ConnectionPool.new(size: 5.to_i, timeout: 10.to_i) do
  Redis.new({
    url: ENV["REDIS_HOST"],
    port: ENV["REDIS_PORT"],
    password: ENV["REDIS_PASSWORD"]
  })
end
