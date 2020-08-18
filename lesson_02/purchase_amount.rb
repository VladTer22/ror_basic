# frozen_string_literal: true

# The amount of purchases. The user alternately enters the name of the product,
# the unit price and the quantity of the purchased product (can be a
# non-integer number). The user can enter an arbitrary number of products
# until he enters "stop" as the name of the product. Based on the entered data,
# the following is required:
# Fill in and display a hash, the keys of which are the names of the goods, and
# the value is a nested hash containing the price per unit of the goods and the
# quantity of the purchased goods. Also display the total amount for each item.
# Calculate and display the total of all purchases in the "basket".

cart = {}
cart_price = 0

loop do
  puts "Set name(or 'stop' when all done): "
  name = gets.chomp
  break if name == 'stop'

  puts 'Set price: '
  price = gets.to_f
  puts 'Set quantity: '
  quantity = gets.to_f

  cart[name] = { price: price, quantity: quantity }
end

cart.each do |key, value|
  sum = value[:price] * value[:quantity]
  puts "Item #{key} price is: #{sum}"
  cart_price += sum
end

puts "Full cart price is #{cart_price}"
p cart
