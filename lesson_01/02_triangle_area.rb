# frozen_string_literal: true

# The area of a triangle can be calculated by knowing its base (a) and
# height (h) by the formula: 1/2 * a * h. The program should query
# the base and height of the triangle and return its area.

print 'Set triangle base: '
a = gets.to_i
print 'Set triangle height: '
h = gets.to_i

area = (a * h) / 2

puts "Triangle area is: #{area}"
