require_relative 'table'
require_relative 'philosopher'
require_relative 'waiter'

names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

philosophers = names.map { |name| Philosopher.new(name) }

table = Table.new(philosophers.size)
waiter = Waiter.new(philosophers.size - 1)

philosophers.each_with_index do |philosopher, i|
  philosopher.async.dine(table, i, waiter)
end

sleep
