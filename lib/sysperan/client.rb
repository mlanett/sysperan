require "json"
require "redis"

module Sysperan
  class Client

    def initialize redis_url = nil
      @redis = Redis.connect redis_url ? { url: redis_url } : {}
      @id    = %x(hostname).strip + ":" + ::Process.pid.to_s
    end

    def perform id = @id, &block
      send :s, id
      yield
    ensure
      send :f, id
    end

    # events have the format [ time, message, id ]
    def send message, id, time = Time.now
      redis.rpush "sysperan:events", [ time.to_i, message, id ].to_json
    end

    private

    def redis
      @redis
    end

  end # Client
end
