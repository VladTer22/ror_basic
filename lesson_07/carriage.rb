# frozen_string_literal: true

require_relative 'company'

# Carriage accessor and show volume
class Carriage
  include Company

  attr_accessor :type, :total_volume, :left, :taked

  def occupied_volume
    taked
  end

  def available_volume
    left
  end
end
