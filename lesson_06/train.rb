# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'valid'

# Set train number, type and carriage quantity, set and show any speed
# add, remove and list carriages, take route, set way and show location
class Train
  include Company
  include InstanceCounter
  include Valid

  attr_accessor :number, :type, :carriage_quantity, :speed, :route, :carriages

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  # rubocop:disable all
  @@trains = {}
  # rubocop:enable all

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type, carriage_quantity)
    @number = number
    @type = type
    @carriage_quantity = carriage_quantity
    @speed = 0
    @@trains[number] = self
    register_instance
    validate!
  end

  def accelerate(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def show_speed
    "Current speed is: #{speed}"
  end

  def unhook_carriage
    speed.zero? ? @carriages.pop && @carriage_quantity -= 1 : 'Stop train first!'
  end

  def take_route(route)
    @route = route

    @station_count = 0
    @local_station = @route.stations[@station_count]
  end

  def move_forward
    if @local_station == @route.stations.last
      'This is final station!'
    else
      @station_count += 1
      @local_station = @route.stations[@station_count]
    end
  end

  def previous_station
    if @local_station == @route.stations.first
      'It\'s first station on your route!'
    else
      "Previous station is: '#{route.stations[@station_count - 1]}'"
    end
  end

  def current_station
    "Currently train on '#{route.stations[@station_count]}' station"
  end

  def next_station
    if @local_station == @route.stations.last
      'It\'s last station on your route!'
    else
      "Next station is: '#{route.stations[@station_count + 1]}'"
    end
  end

  protected

  def validate!
    raise 'Wrong train number!' if @number !~ NUMBER_FORMAT

    raise 'Wrong carriage quantity!' until @carriage_quantity.is_a?(Integer) && @carriage_quantity.positive?

    true
  end
end
