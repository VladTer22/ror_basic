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
#      - Create stations
#      - Create trains
#      - Add wagons to the train
#      - Disconnect wagons from the train
#      - Place trains at the station
#      - View station list and train list at station

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

# methods for interface options
class Main
  def initialize
    @stations = {}
    @trains = {}
  end

  def create_station
    puts 'Set station count: '
    count = gets.to_i
    puts 'Set station name: '
    name = gets.chomp

    @stations[count] = Station.new(name)
    puts "Station #{name} was created!"
  end

  def create_train
    puts 'Train number: '
    self.number = gets.to_i
    puts 'Train type: '
    self.type = gets.chomp
    puts 'Carriage quantity and train sequence: '
    self.carriage_quantity = gets.to_i

    train_check
    puts "#{type} train N#{number} with #{carriage_quantity} carriages was created!"
  end

  def attach_carriage
    puts 'Set train number: '
    self.number = gets.to_i
    puts 'Set carriage type and train sequence: '
    self.type = gets.chomp

    attach_check
    puts "Carriage '#{type}' was attached to train N#{number}"
  end

  def unhook_carriage
    puts 'Set train number and it\'s sequence: '
    self.number = gets.to_i

    unhook_check
    puts "Last carriage was unhooked from train N#{number}"
  end

  def place_train
    puts 'Set train number: '
    self.train_count = gets.to_i
    puts 'Set station name and count: '
    self.name = gets.chomp

    place_train_check
    puts "Train N#{train_count} was placed on '#{name}' station"
  end

  def all_stations
    @stations.each { |key, value| puts "#{key} station is: '#{value.name}'" }
  end

  def placed_trains
    puts 'Set station name: '
    name = gets.chomp

    @stations[name].list_local_trains
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
    if @trains[sequence].number != number
      abort 'This train don\'t exist!'
    else
      @trains[sequence].unhook_carriage
    end
  end

  def place_train_check
    count = gets.to_i
    if @stations[count].name != name
      abort 'This station don\'t exist!'
    else
      @stations[count].take_train(train_count)
    end
  end
end

# User interface
class StartApp < Main
  attr_accessor :action

  def intro
    message = "Create station, press: 1\nCreate train, press: 2\nAttach carriage, press: 3\n" \
              "Unhook carriage, press: 4\nPlace train at the station, press: 5\n" \
              "List stations, press: 6\nTrains on stations, press: 7\nExit, press: 0"
    puts message.chomp

    loop do
      puts 'Choose action: '
      self.action = gets.to_i
      cases
    end
  end

  def cases
    case action
    when 1
      create_station
    when 2
      create_train
    when 3
      attach_carriage
    when 4
      unhook_carriage
    when 5
      place_train
    when 6
      all_stations
    when 7
      placed_trains
    when 0
      exit
    end
  end
end

start = StartApp.new
start.intro
