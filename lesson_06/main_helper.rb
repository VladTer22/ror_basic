# frozen_string_literal: true

# Additional methods for Main
module MainHelper
  attr_accessor :type, :number, :carriage_quantity, :name, :sequence, :chosen_station

  def name_train
    names_checker
    qty_checker
    self.sequence = gets.to_i
    raise 'Wrong train sequence!' until sequence.is_a?(Integer) && sequence.positive?
  end

  def train_check
    if type == 'passenger'
      @trains[sequence] = PassengerTrain.new(number, carriage_quantity)
    elsif type == 'cargo'
      @trains[sequence] = CargoTrain.new(number, carriage_quantity)
    end
  end

  def attach_name
    puts 'Set train number: '
    self.number = gets.chomp
    puts 'Set carriage type and train sequence: '
    self.type = gets.chomp.to_sym
    self.sequence = gets.to_i
  end

  def attach
    @trains[sequence].attach_carriage(type)
    puts "Carriage '#{type}' was attached to train N'#{number}'"
  end

  def attach_check
    attach_name
    if @trains[sequence].number != number
      'This train don\'t exist!'
    elsif @trains[sequence].type != type
      'Wrong carriage type!'
    else
      attach
    end
  end

  def unhook_check
    self.sequence = gets.to_i
    @trains[sequence].number != number ? 'This train don\'t exist!' : @trains[sequence].unhook_carriage
  end

  def place_name
    puts 'Set train number and it\'s sequence: '
    self.number = gets.chomp
    self.sequence = gets.to_i
    puts 'Set station name: '
    self.name = gets.chomp
  end

  def station_check
    self.chosen_station = Station.all.detect { |station| station.name == name }
    raise 'This station don\'t exist!' if chosen_station.nil?
  end

  def place_train_check
    place_name
    station_check
    chosen_station.take_train(@trains[sequence])
  end

  def placed_trains_check
    station_check
    chosen_station.list_trains do |train|
      puts "Train N: #{train.number}, type: #{train.type}, " \
           "carriage quantity: #{train.carriage_quantity}"
    end
  end

  private

  def names_checker
    puts 'Set train number: '
    self.number = gets.chomp
    raise 'Wrong train number!' if number !~ /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

    puts "Set train type('passenger' or 'cargo'): "
    self.type = gets.chomp
    raise 'Wrong train type!' until type == ('cargo' || 'passenger')
  end

  def qty_checker
    puts 'Set carriage quantity and train sequence: '
    self.carriage_quantity = gets.to_i
    raise 'Wrong carriage quantity!' until carriage_quantity.is_a?(Integer) && carriage_quantity.positive?
  end
end
