=begin
Площадь треугольника. Площадь треугольника можно вычилсить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h. Программа должна запрашивать основание и высоту треуголиника и возвращать его площадь.
=end

print "Set triangle base: "
a = gets.to_i
print "Set triangle height: "
h = gets.to_i

area = (a * h) / 2

puts "Triangle area is: #{area}"
