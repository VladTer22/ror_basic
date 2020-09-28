# frozen_string_literal: true

require_relative 'validation'
require_relative 'accessors'

# Passenger train subclass
class PassengerTrain < Train
  include Validation
  extend Accessors

  attr_accessor_with_history :carriage_quantity
  strong_accessor :carriage_quantity, Integer

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def initialize(number, carriage_quantity)
    @number = number
    @type = :passenger
    @carriage_quantity = carriage_quantity
    @speed = 0
    @carriages = []
    init_carriages
    validate!
  end

  def init_carriages
    total_seats = gets.to_i
    raise 'Wrong number of seats!' until total_seats.is_a?(Integer) &&
                                         total_seats.positive? && total_seats < 60
    carriage_quantity.times do
      carriage = PassengerCarriage.new(total_seats)
      @carriages << carriage
    end
  end

  def attach_carriage
    puts 'Set number of seats: '
    total_seats = gets.to_i
    raise 'Wrong number of seats!' until total_seats.is_a?(Integer) &&
                                         total_seats.positive? && total_seats < 60
    carriage = PassengerCarriage.new(total_seats)
    @carriages.push(carriage) && @carriage_quantity += 1
  end
end
