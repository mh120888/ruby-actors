module Actor
  module ClassMethods
    def new(*args, &block)
      Proxy.new(super)
    end
  end

  class << self
    def included(klass)
      klass.extend(ClassMethods)
    end

    def current
      Thread.current[:actor]
    end
  end

  class Proxy
    def initialize(target)
      @target = target
      @mailbox = Queue.new
      @mutex = Mutex.new
      @running = true

      @async_proxy = AsyncProxy.new(self)

      @thread = Thread.new do
        Thread.current[:actor] = self
        process_inbox
      end
    end

    def async
      @async_proxy
    end

    def send_later(method, *args)
      @mailbox << [method, args]
    end

    def terminate
      @running = false
    end

    def method_missing(method, *args)
      process_message(method, *args)
    end

    private

    def process_inbox
      while @running
        method, args = @mailbox.pop
        process_message(method, *args)
      end

    rescue Exception => extend
      puts "Error while running actor: #{ex}"
    end

    def process_message(method, *args)
      @mutex.synchronize do
        @target.public_send(method, *args)
      end
    end
  end

  class AsyncProxy
    def initialize(actor)
      @actor = actor
    end

    def method_missing(method, *args)
      @actor.send_later(method, *args)
    end
  end
end
