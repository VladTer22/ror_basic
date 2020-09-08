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
  end

  def init_carriages
    carriage_quantity.times do
      carriage = CargoCarriage.new
      @carriages << carriage
    end
  end

  def attach_carriage(type)
    if self.type == type && speed.zero?
      carriage = CargoCarriage.new
      @carriages.push(carriage) && @carriage_quantity += 1
    else
      'It can\'t be done!'
    end
  end
end
