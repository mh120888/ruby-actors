require_relative 'actor'

class Chopstick
  include Actor

  def initialize
    @taken = false
  end

  def take
    @taken = true
  end

  def drop
    @taken = false
  end

  def in_use?
    @taken
  end
end
