# frozen_string_literal: true

# It is required to write the following classes:
# Station class:
# Has a name that is indicated when it is created
# Can receive trains (one at a time)
# Can show a list of all trains at the stations that are currently
# Can show a list of trains at the station by type (see below):
# number of freight, passenger
# Can send trains (one at a time, while the train is removed from
# the list of trains at the station).
# Route class:
# Has a start and end station and a list of intermediate stations.
# The starting and ending stations are specified when creating a route,
# and intermediate stations can be added between them.
# Can add an intermediate station to the list
# Can remove an intermediate station from the list
# Can list all stations in order from start to end
# Train class:
# Has a number (arbitrary string) and type (freight, passenger) and the number
# of cars, these data are specified when creating an instance of the class
# Can pick up speed
# Can show current speed
# Can slow down (drop speed to zero)
# Can show the number of wagons
# Can hitch / unhitch wagons (one wagon per operation, the method simply
# increases or decreases the number of wagons). Coupling / uncoupling
# of wagons can be carried out only if the train is not moving.
# Can take a route to follow (an object of the Route class)
# Can move between stations indicated in the route.
# Show previous station, current, next, based on route

# Set the name, take and send trains, list all trains or by type
class Station
  attr_reader :name, :train_count

  def initialize(name)
    @name = name
    @train_count = []
  end

  def take_train(train)
    train_count.push(train)
  end

  def list_local_trains
    train_count.each { |train| puts "Here is train N#{train.number}" }
  end

  def local_trains_by_type(type)
    train_count.each { |train| puts "Here is #{type} train N#{train.number}" if train.type == type }
  end

  def send_train(train)
    train_count.delete(train)
  end
end

# Set start and end station, add and remove intermediate, list all
class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_intermediate_station(station)
    stations.insert(-2, station)
    "Station '#{station}' was added"
  end

  def remove_intermediate_station
    stations.delete_at(-2)
    'Last added station was deleted'
  end

  def list_stations
    "Stations of this route: #{stations.join(', ')}"
  end
end

# Set train number, type and carriage quantity, set and show any speed
# add, remove and list carriages, take route, set way and show location
class Train
  attr_accessor :number, :carriage_quantity, :speed, :route
  attr_reader :type

  def initialize(number, type, carriage_quantity)
    @number = number
    @type = type
    @carriage_quantity = carriage_quantity
    @speed = 0
  end

  def accelerate(speed)
    @speed += speed
  end

  def show_speed
    "Current speed is: #{speed}"
  end

  def stop
    @speed = 0
  end

  def list_carriages
    "Current carriage quantity is: #{carriage_quantity}"
  end

  def attach_carriage
    speed.zero? ? @carriage_quantity += 1 : 'Stop train first!'
  end

  def unhook_carriage
    speed.zero? ? @carriage_quantity -= 1 : 'Stop train first!'
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
