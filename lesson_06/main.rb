# frozen_string_literal: true

# Implement data validation (validation) for all classes.
# Check basic attributes (name, number, type, etc.) for presence,
# length, etc. (depending on the attribute):
#   - Validation should be called when creating an object, if the
#   object is invalid, then an exception should be thrown
#   - Should there be a valid method? which returns true if the
#   object is valid and false otherwise.
# Release a check for the train number format. Valid format:
# three letters or numbers in any order, an optional hyphen
# (maybe or not), and 2 more letters or numbers after the hyphen.
# Remove all puts from classes (except for methods that should
# display something on the screen), methods simply return values.
# (We begin to fight for the purity of the code).
# To release a simple text interface for creating trains (if you
# have already implemented the interface, then add it):
#   - The program asks the user for data to create a train (number
#   and other necessary attributes)
#   - If the attributes are valid, then we display information
#   that such and such a train has been created
#   - If the entered data is invalid, then the program should display a
#   message about the errors that have occurred and re-request the data
#   from the user. Implement this through an exception handling mechanism

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'main_helper'
require_relative 'company'
require_relative 'instance_counter'

# Methods for interface options
class Main
  include MainHelper

  def intro
    puts _message = "1 - Create station\n2 - Create train\n3 - Attach carriage\n" \
                    "4 - Unhook carriage\n5 - List stations\n6 - Place train at the station\n" \
                    "7 - Trains on stations\nOr any other key to exit!"
    loop do
      puts 'Choose action: '
      action = gets.to_i
      send(ACTIONS[action] || exit)
    end
  end

  ACTIONS = { 1 => :create_station,  2 => :create_train,
              3 => :attach_carriage, 4 => :unhook_carriage,
              5 => :all_stations,    6 => :place_train,
              7 => :placed_trains }.freeze

  def initialize
    @stations = []
    @trains = {}
  end

  def create_station
    puts 'Set station name: '
    name = gets.chomp

    @stations << Station.new(name)
    puts "Station '#{name}' was created!"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def create_train
    name_train
    train_check
    raise 'Wrong train sequence!' until sequence.is_a?(Integer) && sequence.positive?
    puts "Train of type '#{type}' N'#{number}' with #{carriage_quantity} carriages was created"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def attach_carriage
    return 'You haven\'t any trains!' if @trains.empty?

    attach_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def unhook_carriage
    return 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number and it\'s sequence: '
    self.number = gets.chomp

    unhook_check
    puts "Last carriage was unhooked from train N'#{number}'"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def all_stations
    return 'You haven\'t any stations!' if @stations.empty?

    @stations.each_with_index { |station, index| puts "#{index + 1} station: '#{station.name}'" }
  end

  def place_train
    return 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    place_train_check
    puts "Train N'#{number}' was placed on '#{name}' station"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def placed_trains
    return 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    puts 'Set station name: '
    self.name = gets.chomp

    placed_trains_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end

Main.new.intro
