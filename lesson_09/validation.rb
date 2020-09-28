# frozen_string_literal: true

# Custom validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class methods validation
  module ClassMethods
    attr_reader :validates
    def validate(name, *args)
      @validates ||= []
      @validates << { name => args }
    end
  end

  # Instace methods validation
  module InstanceMethods
    def validate!
      self.class.validates.each do |data|
        data.each do |name, args|
          value = instance_variable_get("@#{name}")
          send "validate_#{args[0]}", value, *args[1]
        end
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    protected

    def validate_presence(value)
      raise 'Value is nil or empty!' if value.nil? || value.empty?
    end

    def validate_type(value, type)
      raise 'Invalid type!' unless value.is_a? type
    end

    def validate_format(value, format)
      raise 'Wrong format!' if value !~ format
    end
  end
end
