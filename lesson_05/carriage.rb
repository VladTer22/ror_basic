# frozen_string_literal: true

require_relative 'company'

# Carriage accessor
class Carriage
  include Company

  attr_accessor :type
end
