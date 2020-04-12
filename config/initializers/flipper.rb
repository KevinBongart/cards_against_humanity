Flipper.configure do |config|
  config.default do
    client = Redis.new
    adapter = Flipper::Adapters::Redis.new(client)

    Flipper.new(adapter)
  end
end
