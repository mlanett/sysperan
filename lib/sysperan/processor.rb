require "algorithms"

module Sysperan
  class Processor

    INTERVAL = 1 # second
    WINDOW   = 1 # second

    def initialize redis_url = nil
      @buffer   = Containers::BinaryHeap.new() { |a,b| a[0] < b[0] }
      @redis    = Redis.connect redis_url ? { url: redis_url } : {}
    end

    def listen
      # Create a short buffer of 1 second
      # Process all events which are no longer in the buffer
      # Pull in more events into the buffer, up to the buffer size

      process_excess

      # check redis and push into queue
      # if we reach wf then we have accumulated a full buffer and should process the excess
      while m = redis.lpop and Time.now < wf
        buffer << JSON.parse(m)
      end

    end # listen

    # process all events leading up to T-1
    def process_excess
      while true do
        # < ... wp = buffer excess which we should process asap
        # wp .. w0 = buffer
        # w0 .. wf = time we are willing to spend filling the buffer
        w0 = Time.now
        wf = w0 + 1
        wp = w0 - WINDOW

        # break if we have no matching events
        break if ! ( event = buffer.next ) or event[0] >= wp

        # if we have some matching events, process them
        # afterwards loop to see if more events match as Time.now will have advanced
        while event = buffer.next and event[0] < wp
          process buffer.pop
        end
      end
    end

    # events have the format [ time, message, id ]
    def process event
    end

    private

    def buffer
      @buffer
    end

    def redis
      @redis
    end

  end # Processor
end
