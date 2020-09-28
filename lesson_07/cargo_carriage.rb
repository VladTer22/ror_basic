# frozen_string_literal: true

# Initialize carriage type and take volume
class CargoCarriage < Carriage
  def initialize(total_volume)
    @total_volume = total_volume
    @left = total_volume
    @taked = 0
    @type = :cargo
  end

  def take_volume(volume)
    self.left = total_volume - volume
    self.taked = total_volume - left
  end
end
