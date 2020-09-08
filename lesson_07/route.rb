# frozen_string_literal: true

require_relative 'valid'

# Set start and end station, add and remove intermediate, list all
class Route
  include Valid

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
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

  protected

  def validate!
    raise 'Wrong route length!' if @stations.length < 2

    true
  end
end
