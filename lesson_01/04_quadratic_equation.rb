# frozen_string_literal: true

# The user enters 3 coefficients a, b and c. The program calculates
# the discriminant (D) and the roots of the equation (x1 and x2, if any)
# and displays the values of the discriminant and roots on the screen.
# In this case, the following options are possible:
# If D> 0, then we derive the discriminant and 2 roots
# If D = 0, then we print the discriminant and 1 root (they are equal)
# If D <0, then display the discriminant and the message "No roots"
# Hint: Solution algorithm with flowchart (www.bolshoyvopros.ru).
# To calculate the square root, you need to use Math.sqrt
# For example, Math.sqrt (16) will return 4, i.e. the square root of 16.

print 'Set a: '
a = gets.to_i
print 'Set b: '
b = gets.to_i
print 'Set c: '
c = gets.to_i

d = b**2 - 4 * a * c

if d.positive?
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "D = #{d} \nx1 = #{x1} \nx2 = #{x2}"
elsif d.zero?
  x1 = -b / (2 * a)
  puts "D = #{d} \nx = #{x1}"
else
  puts "D = #{d} \nNo roots"
end
