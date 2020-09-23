# frozen_string_literal: true

# For passenger cars:
# Add an attribute of the total number of seats (set when creating a car)
# Add a method that "takes up seats" in the carriage (one at a time)
# Add a method that returns the number of occupied seats in the car
# Add a method that returns the number of free seats in the carriage.

# For freight cars:
# Add an attribute of the total volume (set when creating a car)
# Add a method that "occupies volume" in the car (the volume is specified
# as a method parameter)
# Add a method that returns the occupied space
# Add a method that returns the remaining (available) volume

# The Station class has:
# write a method that takes a block and traverses all trains in a station,
# passing each train into a block.

# The Train class has:
# write a method that takes a block and passes through all the cars of the
# train (the cars must be in the internal array), passing each car object
# to the block.

# If there is no interface, then in a separate file, for example, main.rb,
# write the code that:
# Creates test data (stations, trains, carriages) and links them together.
# Using the methods created within the task, write a code that iterates
# through all stations sequentially and for each station displays a list
# of trains in the format:
#   - Train number, type, number of cars
# And for each train at the station, display a list of cars in the format:
#   - Car number (can be assigned automatically), car type, number of free
# and occupied seats (for a passenger car) or number of free and occupied
# space (for freight cars).

# If you have an interface, then add features:
# When creating a wagon, indicate the number of seats or the total volume,
# depending on the type of wagon
# Display a list of wagons by the train (in the format indicated above)
# Display the list of trains at the station (in the above format)
# Take up space or volume in the carriage

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
                    "4 - Unhook carriage\n5 - Fill carriage\n6 - List carriages\n" \
                    "7 - List stations\n8 - Place train at the station\n" \
                    "9 - Trains on stations\nOr any other key to exit!"
    loop do
      puts 'Choose action: '
      action = gets.to_i
      send(ACTIONS[action] || exit)
    end
  end

  ACTIONS = { 1 => :create_station,  2 => :create_train,
              3 => :attach_carriage, 4 => :unhook_carriage,
              5 => :fill_carriage,   6 => :train_carriages,
              7 => :all_stations,    8 => :place_train,
              9 => :placed_trains }.freeze

  def initialize
    @stations = []
    @trains = {}
  end

  def create_station
    station_name_checker

    @stations << Station.new(name)
    puts "Station '#{name}' was created"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def create_train
    name_train
    train_check
    puts "Train of type '#{type}' N'#{number}' with #{carriage_quantity} carriages was created"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def train_carriages
    raise 'Create train first!' if @trains.empty?

    number_checker
    sequence_checker
    @trains[sequence].list_carriages do |carriage, index|
      puts "Train N'#{number}' #{index + 1} carriage type: #{carriage.type}, occupied: " \
           "#{carriage.occupied_volume}, available: #{carriage.available_volume}"
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def attach_carriage
    raise 'Create train first!' if @trains.empty?

    attach_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def unhook_carriage
    raise 'Create train first!' if @trains.empty?

    unhook_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def fill_carriage
    raise 'Create train first!' if @trains.empty?

    fill_check
    puts "Carriage number #{carriage_number} of train N'#{number}' was succesfully filled"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def all_stations
    raise 'You haven\'t any stations!' if @stations.empty?

    @stations.each_with_index { |station, index| puts "#{index + 1} station: '#{station.name}'" }
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def place_train
    raise 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    place_train_check
    puts "Train N'#{number}' was placed on '#{name}' station"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def placed_trains
    raise 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    station_name_checker
    placed_trains_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end

Main.new.intro
