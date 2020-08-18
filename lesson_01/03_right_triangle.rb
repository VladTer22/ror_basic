# frozen_string_literal: true

# The program asks the user for 3 sides of the triangle and determines if
# the triangle is rectangular using the Pythagorean theorem (www-formula.ru)
# and displays the result on the screen. Also, if the triangle is at the same
# time isosceles (that is, it has any 2 sides equal), then additional
# information is displayed that the triangle is also isosceles.
# Hint: to use the Pythagorean theorem, you must first find the longest side
# (hypotenuse) and compare its value squared with the sum of the squares of
# the other two sides. If all 3 sides are equal, then the triangle is isosceles
# and equilateral, but not right-angled.

print 'Set first triangle side: '
a = gets.to_i
print 'Set second triangle side: '
b = gets.to_i
print 'Set third triangle side: '
c = gets.to_i

if a > b && a > c
  h = a
  c1 = b
  c2 = c
elsif b > a && b > c
  h = b
  c1 = a
  c2 = c
elsif c > a && c > b
  h = c
  c1 = a
  c2 = b
else
  abort "Triangle can't be right!"
end

if h**2 == c1**2 + c2**2 && c1 == c2
  puts 'Right and isosceles triangle.'
elsif h**2 == c1**2 + c2**2
  puts 'Right triangle.'
else
  puts "Triangle isn't right."
end
