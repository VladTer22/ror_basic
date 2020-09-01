# frozen_string_literal: true

# Cargo train subclass
class CargoTrain < Train
  def initialize(number, carriage_quantity)
    @number = number
    @type = :cargo
    @carriage_quantity = carriage_quantity
    @speed = 0
    carriage = CargoCarriage.new
    @carriages = Array.new(self.carriage_quantity, carriage)
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
