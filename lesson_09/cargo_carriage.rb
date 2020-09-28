# frozen_string_literal: true

require_relative 'validation'

# Initialize carriage type and take volume
class CargoCarriage < Carriage
  include Validation

  validate :total_volume, :type, Integer

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
