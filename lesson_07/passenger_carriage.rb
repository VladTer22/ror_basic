# frozen_string_literal: true

# Initialize carriage type and take volume
class PassengerCarriage < Carriage
  def initialize(total_seats)
    @total_volume = total_seats
    @left = total_seats
    @taked = 0
    @type = :passenger
  end

  def take_volume
    self.taked += 1
    self.left = total_volume - taked
  end
end
