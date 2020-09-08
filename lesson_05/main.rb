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
require_relative 'company'
require_relative 'instance_counter'

# Methods for interface options
# rubocop:disable all
class Main
# rubocop:enable all
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
  end

  def create_train
    name_train
    train_check
    puts "Train of type '#{type}' N'#{number}' with #{carriage_quantity} carriages was created"
  end

  def attach_carriage
    return 'You haven\'t any trains!' if @trains.empty?

    attach_check
  end

  def unhook_carriage
    return 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number and it\'s sequence: '
    self.number = gets.to_i

    unhook_check
    puts "Last carriage was unhooked from train N'#{number}'"
  end

  def all_stations
    return 'You haven\'t any stations!' if @stations.empty?

    @stations.each_with_index { |station, index| puts "#{index + 1} station: '#{station.name}'" }
  end

  def place_train
    return 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    place_train_check
    puts "Train N'#{number}' was placed on '#{name}' station"
  end

  def placed_trains
    return 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    puts 'Set station name: '
    self.name = gets.chomp

    placed_trains_check
  end

  private

  attr_accessor :type, :number, :carriage_quantity, :name, :sequence, :chosen_station

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
      'Wrong train type!'
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
    puts "Carriage '#{type}' was attached to train N'#{number}'"
  end

  def attach_check
    attach_name
    if @trains[sequence].number != number
      'This train don\'t exist!'
    elsif @trains[sequence].type != type
      'Wrong carriage type!'
    else
      attach
    end
  end

  def unhook_check
    self.sequence = gets.to_i
    @trains[sequence].number != number ? 'This train don\'t exist!' : @trains[sequence].unhook_carriage
  end

  def place_name
    puts 'Set train number and it\'s sequence: '
    self.number = gets.chomp
    self.sequence = gets.to_i
    puts 'Set station name: '
    self.name = gets.chomp
  end

  def station_check
    self.chosen_station = Station.all.detect { |station| station.name == name }
    return 'This station don\'t exist!' if chosen_station.nil?
  end

  def place_train_check
    place_name
    station_check
    chosen_station.take_train(@trains[sequence])
  end

  def placed_trains_check
    station_check
    chosen_station.list_trains do |train|
      puts "Train N: #{train.number}, type: #{train.type}, " \
           "carriage quantity: #{train.carriage_quantity}"
    end
  end
end

Main.new.intro
