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
require_relative 'start'
require_relative 'company'
require_relative 'instance_counter'

# Methods for interface options
# rubocop:disable all
class Main
# rubocop:enable all
  include Start

  def initialize
    @stations = {}
    @trains = {}
  end

  def create_station
    puts 'Set station name and it\'s count: '
    name = gets.chomp
    count = gets.to_i

    raise 'Wrong station count!' until count.is_a?(Integer) && count.positive?
    @stations[count] = Station.new(name)
    puts "Station '#{name}' was created!"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def create_train
    name_train
    train_check
    raise 'Wrong train sequence!' until sequence.is_a?(Integer) && sequence.positive?
    puts "Train of type '#{type}' N#{number} with #{carriage_quantity} carriages was created!"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def attach_carriage
    return puts 'You haven\'t any trains!' if @trains.empty?

    attach_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def unhook_carriage
    return puts 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number and it\'s sequence: '
    self.number = gets.chomp

    unhook_check
    puts "Last carriage was unhooked from train N#{number}"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def place_train
    return puts 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    place_train_check
    puts "Train N#{number} was placed on '#{name}' station"
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  def all_stations
    return puts 'You haven\'t any stations!' if @stations.empty?

    @stations.each { |key, value| puts "#{key} station is: '#{value.name}'" }
  end

  def placed_trains
    return puts 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    puts 'Set station name and count: '
    self.name = gets.chomp

    placed_trains_check
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  private

  attr_accessor :type, :number, :carriage_quantity, :name, :sequence

  def name_train
    puts 'Set train number: '
    self.number = gets.chomp
    puts "Set train type('passenger' or 'cargo'): "
    self.type = gets.chomp
    puts 'Set carriage quantity and train sequence: '
    self.carriage_quantity = gets.to_i
    self.sequence = gets.to_i
  end

  def train_check
    if type == 'passenger'
      @trains[sequence] = PassengerTrain.new(number, carriage_quantity)
    elsif type == 'cargo'
      @trains[sequence] = CargoTrain.new(number, carriage_quantity)
    else
      raise 'Wrong train type!'
    end
  end

  def attach_name
    puts 'Set train number: '
    self.number = gets.chomp
    puts 'Set carriage type and train sequence: '
    self.type = gets.chomp.to_sym
    self.sequence = gets.to_i
  end

  def attach
    @trains[sequence].attach_carriage(type)
    puts "Carriage '#{type}' was attached to train N#{number}"
  end

  def attach_check
    attach_name
    if @trains[sequence].number != number
      puts 'This train don\'t exist!'
    elsif @trains[sequence].type != type
      puts 'Wrong carriage type!'
    else
      attach
    end
  end

  def unhook_check
    self.sequence = gets.to_i
    @trains[sequence].number != number ? (puts 'This train don\'t exist!') : @trains[sequence].unhook_carriage
  end

  def place_name
    puts 'Set train number: '
    self.number = gets.chomp
    puts 'Set station name and count: '
    self.name = gets.chomp
  end

  def place_train_check
    place_name
    count = gets.to_i
    @stations[count].name != name ? (puts 'This station don\'t exist!') : @stations[count].take_train(number)
  end

  def placed_trains_check
    count = gets.to_i
    @stations[count].name != name ? (puts 'This station don\'t exist!') : @stations[count].list_local_trains
  end
end

start = Main.new
start.intro
