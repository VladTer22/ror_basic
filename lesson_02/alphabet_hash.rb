# frozen_string_literal: true

# Fill in the hash with vowels, where the value is the ordinal number of the letter in the alphabet (a - 1).

alphabet = ('a'..'z')
hash = {}

alphabet.each_with_index do |key, index|
  hash[key] = index + 1 if %w[a e o u i].include?(key)
end

puts "Vowels in alphabet: \n#{hash}"
