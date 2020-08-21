# frozen_string_literal: true

# The program asks the user for his name and height and displays the ideal
# weight according to the formula <height> - 110, after which it displays
# the result to the user on the screen with a call by name. If the ideal
# weight turns out to be negative, then the line
# "Your weight is already optimal" is displayed

puts "What's your name?"
name = gets.chomp
puts "What's your height?"
height = gets.to_i

perfect_weight = height - 110

if perfect_weight.negative?
  puts 'Your weight is already OK'
else
  puts "#{name}, your perfect weight is: #{perfect_weight}"
end
