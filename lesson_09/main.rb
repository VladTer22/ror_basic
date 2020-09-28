# frozen_string_literal: true

# Write an Acessors module containing the following methods
# that can be called at the class level:
# method
#   attr_accessor_with_history
# This method dynamically creates getters and setters for any number
# of attributes, while the setter retains all values of the instance variable
# when this value changes. Also, an instance method should be added
# to the class into which the module is connected
#  <attribute_name> _history
# which returns an array of all values of the given variable.
# method
#   strong_attr_acessor
# which takes an attribute name and its class. This creates a getter and
# a setter for the instance variable of the same name, but the setter checks
# the type of the assigned value. If the type is different from the one
# specified by the second parameter, an exception is thrown. If the type
# is the same, then the value is assigned.
# Write a Validation module that:
# Contains the class method validate. This method takes as parameters the name
# of the attribute being checked, as well as the type of validation and,
# if necessary, additional parameters. Possible types of validations:
# - presence - requires the attribute value to be non-nil and not an empty string.
# Usage example:
# validate: name,: presence
# - format (in this case, a regular expression for the format is set as a separate parameter).
# Treble matches the attribute value with the specified regular expression. Example:
# validate: number,: format, / A-Z {0,3} /
# - type (the third parameter is the attribute class). Requires the attribute value to match
# the specified class. Example:
# validate: station,: type, RailwayStation
# Contains an instance method validate !, which runs all the checks (validations) specified
# in the class via the class method validate. In case of validation error, throws an
# exception with a message about which validation failed.
# Contains an instance method valid? which returns true if all validation checks
# are successful and false if there are validation errors.

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
require_relative 'validation'
require_relative 'accessors'

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
    number_checker
    type_checker
    carr_qty_checker
    sequence_checker
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

    number_checker
    type_checker
    sequence_checker
    attach_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def unhook_carriage
    raise 'Create train first!' if @trains.empty?

    number_checker
    sequence_checker
    unhook_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def fill_carriage
    raise 'Create train first!' if @trains.empty?

    number_checker
    sequence_checker
    carr_num_checker
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
