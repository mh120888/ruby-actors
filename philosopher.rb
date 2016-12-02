require_relative 'actor'

class Philosopher
  include Actor

  def initialize(name)
    @name = name
  end

  def dine(table, position, waiter)
    @waiter = waiter

    @left_chopstick  = table.left_chopstick_at(position)
    @right_chopstick = table.right_chopstick_at(position)

    think
  end

  def think
    puts "#{@name} is thinking"
    sleep(rand)

    @waiter.async.request_to_eat(Actor.current)
  end

  def eat
    take_chopsticks

    puts "#{@name} is eating."
    sleep(rand)

    drop_chopsticks

    @waiter.async.done_eating(Actor.current)

    think
  end

  def take_chopsticks
    @left_chopstick.async.take
    @right_chopstick.async.take
  end

  def drop_chopsticks
    @left_chopstick.async.drop
    @right_chopstick.async.drop
  end

  def finalize
    drop_chopsticks
  end
end
