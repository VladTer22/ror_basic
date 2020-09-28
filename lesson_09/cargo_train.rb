# frozen_string_literal: true

require_relative 'validation'
require_relative 'accessors'

# Cargo train subclass
class CargoTrain < Train
  include Validation
  extend Accessors

  attr_accessor_with_history :type
  strong_accessor :type, Symbol

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def initialize(number, carriage_quantity)
    @number = number
    @type = :cargo
    @carriage_quantity = carriage_quantity
    @speed = 0
    @carriages = []
    init_carriages
    validate!
  end

  def init_carriages
    total_volume = gets.to_i
    raise 'Wrong carriages volume!' until total_volume.is_a?(Integer) &&
                                          total_volume.positive? && total_volume < 800
    carriage_quantity.times do
      carriage = CargoCarriage.new(total_volume)
      @carriages << carriage
    end
  end

  def attach_carriage
    puts 'Set carriage volume: '
    total_volume = gets.to_i
    raise 'Wrong carriages volume!' until total_volume.is_a?(Integer) &&
                                          total_volume.positive? && total_volume < 800
    carriage = CargoCarriage.new(total_volume)
    @carriages.push(carriage) && @carriage_quantity += 1
  end
end
