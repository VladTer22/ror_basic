# frozen_string_literal: true

# Check, valid object or not
module Valid
  def valid?
    validate!
  rescue StandardError
    false
  end
end
