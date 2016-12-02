require_relative 'chopstick'

class Table
  def initialize(num_seats)
    @chopsticks = num_seats.times.map { Chopstick.new }
  end

  def left_chopstick_at(position)
    index = (position - 1) % @chopsticks.size
    @chopsticks[index]
  end

  def right_chopstick_at(position)
    index = position % @chopsticks.size
    @chopsticks[index]
  end

  def chopsticks_in_use
    @chopsticks.select { |chopstick| chopstick.in_use? }.size
  end
end