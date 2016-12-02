require_relative 'actor'

class Waiter
  include Actor

  def initialize(capacity)
    @eating = []
  end

  def request_to_eat(philosopher)
    return if @eating.include?(philosopher)

    @eating << philosopher
    philosopher.async.eat
  end

  def done_eating(philosopher)
    @eating.delete(philosopher)
  end
end