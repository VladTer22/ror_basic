# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'valid'

# Set the name, take and send trains, list all trains or by type
class Station
  include InstanceCounter
  include Valid

  attr_accessor :name, :train_count

  NAME_FORMAT = /[a-z]/i.freeze

  # rubocop:disable all
  @@stations = []
  # rubocop:enable all

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @train_count = []
    @@stations << self
    register_instance
    validate!
  end

  def take_train(train)
    train_count.push(train)
  end

  def send_train(train)
    train_count.delete(train)
  end

  def list_trains
    return 'There are no trains at this station!' if train_count.empty?

    train_count.each { |train| yield train }
  end

  def local_trains_by_type(type)
    train_count.each { |train| puts "Here is #{type} train N'#{train}'" if train.type == type }
  end

  protected

  def validate!
    raise 'Wrong station name!' if @name !~ NAME_FORMAT

    true
  end
end
