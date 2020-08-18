=begin
Заполнить массив числами фибоначи до 100.
=end

array = []

i = 0
j = 1
l = 100

while i < l
  array << i
  i, j = j, i + j
end

puts "Fibonacci array: \n#{array}"
