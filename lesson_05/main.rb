# frozen_string_literal: true

# Create a module that will allow you to specify the name of the manufacturer
# and get it. Connect the module to the Wagon and Train classes
# In the Station class (railway station) create a method of the class all,
# which returns all stations (objects) created at the moment
# Add the Number attribute (arbitrary string) to the train, if it
# does not exist yet, which is specified when it is created
# In the Train class, create a method of the find class that takes
# the train number (specified when it was created) and returns a train
# object by number or nil if no train with that number is found.
# Create an InstanceCounter module containing the following class methods
# and instance methods that are automatically connected when you call
# include in the class:
# Class Methods:
#   - instances, which returns the number of instances of this class
# Inastance methods:
#   - register_instance, which increases the counter of the number
#   of class instances and which can be called from the constructor.
#   Moreover, this method should not be public.

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
class Main
  include Start

  def initialize
    @stations = {}
    @trains = {}
  end

  def create_station
    puts 'Set station name: '
    name = gets.chomp
    puts 'Set station count: '
    count = gets.to_i

    @stations[count] = Station.new(name)
    puts "Station '#{name}' was created!"
  end

  def name_train
    puts 'Set train number: '
    self.number = gets.to_i
    puts 'Set train type: '
    self.type = gets.chomp
    puts 'Set carriage quantity and train sequence: '
    self.carriage_quantity = gets.to_i
  end

  def create_train
    name_train
    train_check
    puts "Train of type '#{type}' N#{number} with #{carriage_quantity} carriages was created!"
  end

  def attach_carriage
    abort 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number: '
    self.number = gets.to_i
    puts 'Set carriage type and train sequence: '
    self.type = gets.chomp

    attach_check
    puts "Carriage '#{type}' was attached to train N#{number}"
  end

  def unhook_carriage
    abort 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number and it\'s sequence: '
    self.number = gets.to_i

    unhook_check
    puts "Last carriage was unhooked from train N#{number}"
  end

  def place_train
    abort 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    puts 'Set train number: '
    self.train_count = gets.to_i
    puts 'Set station name and count: '
    self.name = gets.chomp

    place_train_check
    puts "Train N#{train_count} was placed on '#{name}' station"
  end

  def all_stations
    abort 'You haven\'t any stations!' if @stations.empty?

    @stations.each { |key, value| puts "#{key} station is: '#{value.name}'" }
  end

  def placed_trains
    abort 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    puts 'Set station name and count: '
    self.name = gets.chomp

    placed_trains_check
  end

  private

  attr_accessor :type, :number, :carriage_quantity, :name, :train_count

  def train_check
    sequence = gets.to_i
    if type == 'passenger'
      @trains[sequence] = PassengerTrain.new(number, type, carriage_quantity)
    elsif type == 'cargo'
      @trains[sequence] = CargoTrain.new(number, type, carriage_quantity)
    else
      abort 'Wrong train type!'
    end
  end

  def attach_check
    sequence = gets.to_i
    if @trains[sequence].number != number
      abort 'This train don\'t exist!'
    elsif @trains[sequence].type != type
      abort 'Wrong carriage type!'
    else
      @trains[sequence].attach_carriage(type)
    end
  end

  def unhook_check
    sequence = gets.to_i
    @trains[sequence].number != number ? (abort 'This train don\'t exist!') : @trains[sequence].unhook_carriage
  end

  def place_train_check
    count = gets.to_i
    @stations[count].name != name ? (abort 'This station don\'t exist!') : @stations[count].take_train(train_count)
  end

  def placed_trains_check
    count = gets.to_i
    @stations[count].name != name ? (abort 'This station don\'t exist!') : @stations[count].list_local_trains
  end
end

start = Main.new
start.intro
