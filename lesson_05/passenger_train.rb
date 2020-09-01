# frozen_string_literal: true

# Passenger train subclass
class PassengerTrain < Train
  def initialize(number, carriage_quantity)
    @number = number
    @type = :passenger
    @carriage_quantity = carriage_quantity
    @speed = 0
    carriage = PassengerCarriage.new
    @carriages = Array.new(self.carriage_quantity, carriage)
  end

  def attach_carriage(type)
    if self.type == type && speed.zero?
      carriage = PassengerCarriage.new
      @carriages.push(carriage) && @carriage_quantity += 1
    else
      'It can\'t be done!'
    end
  end
end
