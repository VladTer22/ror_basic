# frozen_string_literal: true

# Set train number, type and carriage quantity, set and show any speed
# add, remove and list carriages, take route, set way and show location
class Train
  attr_accessor :number, :type, :carriage_quantity, :speed, :route, :carriages

  def initialize(number, type, carriage_quantity)
    @number = number
    @type = type
    @carriage_quantity = carriage_quantity
    @speed = 0
    @carriages = Array.new(self.carriage_quantity, self.type)
  end

  def accelerate(speed)
    self.speed += speed
  end

  def show_speed
    "Current speed is: #{speed}"
  end

  def stop
    self.speed = 0
  end

  def list_carriages
    "Current carriage quantity is: #{@carriages.length}"
  end

  def attach_carriage(type)
    self.type == type && speed.zero? ? @carriages.push(type) : 'It can\'t be done!'
  end

  def unhook_carriage
    speed.zero? ? @carriages.pop : 'Stop train first!'
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
end
