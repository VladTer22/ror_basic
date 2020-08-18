# frozen_string_literal: true

# Fill the array with Fibonacci numbers up to 100

array = []

i = 0
j = 1
l = 100

while i < l
  array << i
  i, j = j, i + j
end

puts "Fibonacci array: \n#{array}"
