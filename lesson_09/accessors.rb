# frozen_string_literal: true

# Custom accessors
module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      line = "@#{name}".to_sym
      line_history = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(line) }
      setter
      define_method("#{name}_history".to_sym) do
        instance_variable_get(line_history) || []
      end
    end
  end

  def strong_accessor(name, clazz)
    define_method(name.to_s.to_sym) { instance_variable_get("@#{name}".to_sym) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong value type!' unless value.is_a? clazz

      instance_variable_set("@#{name}".to_sym, value)
    end
  end

  protected

  def setter
    define_method("#{name}=".to_sym) do |value|
      history = instance_variable_get(line_history) || []
      history << value
      instance_variable_set(line_history, history)
      instance_variable_set(line, value)
    end
  end
end
