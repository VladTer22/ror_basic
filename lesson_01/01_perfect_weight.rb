=begin
Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле <рост> - 110, после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"
=end

puts "What's your name?"
name = gets.chomp
puts "What's your height?"
height = gets.to_i

perfect_weight = height - 110

if perfect_weight.negative?
  puts "Your weight is already OK"
else
  puts "#{name}, your perfect weight is: #{perfect_weight}"
end
