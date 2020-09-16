# frozen_string_literal: true

# Passenger train subclass
class PassengerTrain < Train
  def initialize(number, carriage_quantity)
    @number = number
    @type = :passenger
    @carriage_quantity = carriage_quantity
    @speed = 0
    @carriages = []
    init_carriages
  end

  def init_carriages
    carriage_quantity.times do
      carriage = PassengerCarriage.new
      @carriages << carriage
    end
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
