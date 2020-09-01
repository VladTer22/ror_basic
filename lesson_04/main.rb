# frozen_string_literal: true

# Split the program into separate classes (each class in a separate file)
# Divide trains into two types PassengerTrain and CargoTrain, make a parent
# for the classes, which will contain common methods and properties
# Determine which methods can be placed in private / protected and move them
# into such a section. In a comment to the method, justify why
# it was moved to private / protected
# Cars are now divided into freight and passenger (separate classes).
# Only passenger trains can be attached to a passenger train,
# and freight trains can be attached to a freight train. When adding
# a carriage to a train, the carriage object should be saved in the train's
# internal array, unlike the previous task, where we counted only the number
# of cars. The constructor parameter "number of cars" can be deleted.
# Complicated task: create a program in the main.rb file that will allow
# the user through a text interface to do the following:
# - Create stations
# - Create trains
# - Add wagons to the train
# - Disconnect wagons from the train
# - Place trains at the station
# - View station list and train list at station

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'start'

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
    puts "Set train type('passenger' or 'cargo'): "
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
    return puts 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number: '
    self.number = gets.to_i
    puts 'Set carriage type and train sequence: '
    self.type = gets.chomp.to_sym

    attach_check
  end

  def unhook_carriage
    return puts 'You haven\'t any trains!' if @trains.empty?

    puts 'Set train number and it\'s sequence: '
    self.number = gets.to_i

    unhook_check
    puts "Last carriage was unhooked from train N#{number}"
  end

  def place_train
    return puts 'Create trains and stations first!' if @stations.empty? || @trains.empty?

    puts 'Set train number: '
    self.train_count = gets.to_i
    puts 'Set station name and count: '
    self.name = gets.chomp

    place_train_check
    puts "Train N#{train_count} was placed on '#{name}' station"
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
  end

  private

  attr_accessor :type, :number, :carriage_quantity, :name, :train_count

  def train_check
    sequence = gets.to_i
    if type == 'passenger'
      @trains[sequence] = PassengerTrain.new(number, carriage_quantity)
    elsif type == 'cargo'
      @trains[sequence] = CargoTrain.new(number, carriage_quantity)
    else
      puts 'Wrong train type!'
    end
  end

  def attach_check
    sequence = gets.to_i
    if @trains[sequence].number != number
      puts 'This train don\'t exist!'
    elsif @trains[sequence].type != type
      puts 'Wrong carriage type!'
    else
      @trains[sequence].attach_carriage(type)
      puts "Carriage '#{type}' was attached to train N#{number}"
    end
  end

  def unhook_check
    sequence = gets.to_i
    @trains[sequence].number != number ? 'This train don\'t exist!' : @trains[sequence].unhook_carriage
  end

  def place_train_check
    count = gets.to_i
    @stations[count].name != name ? 'This station don\'t exist!' : @stations[count].take_train(train_count)
  end

  def placed_trains_check
    count = gets.to_i
    @stations[count].name != name ? 'This station don\'t exist!' : @stations[count].list_local_trains
  end
end

start = Main.new
start.intro
