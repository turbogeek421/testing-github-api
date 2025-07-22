# frozen_string_literal: true

config = {}
config[:host] = ENV["REDIS_HOST"] || "redis"
config[:port] = ENV["REDIS_PORT"] || 6379
config[:password] = ENV["REDIS_PASSWORD"] if ENV["REDIS_PASSWORD"].present?
config[:db] = 2

Sidekiq.configure_server do |c|
  c.redis = config.merge(db: 1, network_timeout: 5)
end

Sidekiq.configure_client do |c|
  c.redis = config.merge(db: 1, network_timeout: 5)
end

Redis.current = Redis.new(config)
