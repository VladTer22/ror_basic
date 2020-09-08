# frozen_string_literal: true

# Cargo train subclass
class CargoTrain < Train
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
    carriage_quantity.times do
      carriage = CargoCarriage.new(total_volume)
      @carriages << carriage
    end
  end

  def attach_carriage(type)
    if self.type == type && speed.zero?
      puts 'Set carriage volume: '
      total_volume = gets.to_i
      carriage = CargoCarriage.new(total_volume)
      @carriages.push(carriage) && @carriage_quantity += 1
    else
      'It can\'t be done!'
    end
  end
end
