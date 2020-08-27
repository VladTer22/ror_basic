# frozen_string_literal: true

# Set the name, take and send trains, list all trains or by type
class Station
  include InstanceCounter

  attr_accessor :name, :train_count

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
  end

  def take_train(train)
    train_count.push(train)
  end

  def list_local_trains
    abort 'There are no trains at this station!' if train_count.empty?

    train_count.each { |train| puts "Here is train N#{train}" }
  end

  def local_trains_by_type(type)
    train_count.each { |train| puts "Here is #{type} train N#{train}" if train.type == type }
  end

  def send_train(train)
    train_count.delete(train)
  end
end
