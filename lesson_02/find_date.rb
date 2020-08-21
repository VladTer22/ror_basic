# frozen_string_literal: true

# Three numbers are given, which denote the day, month, year (we ask the user).
# Find the ordinal number of the date starting from the beginning of the year.
# Please note that the year can be a leap year. (Is it forbidden to use
# built-in ruby methods for this like Date # yday or Date # leap?)
# Algorithm for determining a leap year: www.adm.yar.ru

puts 'Set day: '
day = gets.to_i
puts 'Set month: '
month = gets.to_i
puts 'Set year: '
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = 29 if (year % 400).zero? || year % 100 != 0 && (year % 4).zero?
abort 'Invalid data!' unless day >= 1 && day <= months[month - 1] && month >= 1 &&
                             month <= months.length && year >= 1 && year <= 2020
abort 'You can\'t set this days quantity for this month!' if month == 2 && day > months[1]

days = 0
months.each_with_index do |element, index|
  days += element if index < month - 1
end
days += day

puts "Ordinal number of the date is: #{days}"
