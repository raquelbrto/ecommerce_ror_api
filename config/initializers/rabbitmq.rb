require "bunny"

rabbitmq_url = ENV["RABBITMQ_URL"] || "amqp://guest:guest@localhost:5672/"

conn = Bunny.new(rabbitmq_url)
conn.start

channel = conn.create_channel
