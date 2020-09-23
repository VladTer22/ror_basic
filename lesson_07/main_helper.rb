# frozen_string_literal: true

# Additional methods for Main
module MainHelper
  attr_accessor :type, :number, :carriage_quantity, :name, :sequence,
                :chosen_station, :carriage_number, :chosen_carriage

  def name_train
    number_checker
    type_checker
    carr_qty_checker
    sequence_checker
  end

  def passenger_train
    puts 'Set number of seats(up to 60): '
    @trains[sequence] = PassengerTrain.new(number, carriage_quantity)
  end

  def cargo_train
    puts 'Set carriages volume(up to 800): '
    @trains[sequence] = CargoTrain.new(number, carriage_quantity)
  end

  def train_check
    if type == :passenger
      passenger_train
    elsif type == :cargo
      cargo_train
    end
  end

  def attach_name
    number_checker
    type_checker
    sequence_checker
  end

  def attach
    @trains[sequence].attach_carriage
    puts "Carriage '#{type}' was attached to train N'#{number}'"
  end

  def attach_check
    attach_name
    raise 'Wrong train number!' if @trains[sequence].number != number
    raise 'Wrong train type!' if @trains[sequence].type != type

    attach
  end

  def unhook_check
    number_checker
    sequence_checker
    raise 'Wrong train number!' if @trains[sequence].number != number

    @trains[sequence].unhook_carriage
    puts "Last carriage was unhooked from train N'#{number}'"
  end

  def fill_name
    number_checker
    sequence_checker
    carr_num_checker
  end

  def fill_cargo
    puts 'Set the volume to be taken: '
    volume = gets.to_i
    raise 'It\'s too hight value!' if volume > chosen_carriage.available_volume

    chosen_carriage.take_volume(volume)
  end

  def fill_check
    fill_name
    self.chosen_carriage = @trains[sequence].carriages[carriage_number - 1]
    type = @trains[sequence].type
    if type == :cargo
      fill_cargo
    elsif type == :passenger
      chosen_carriage.take_volume
    end
  end

  def place_name
    number_checker
    sequence_checker
    station_name_checker
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
    raise 'Station is empty!' if chosen_station.train_count.empty?

    chosen_station.list_trains do |train|
      puts "Train N: #{train.number}, type: #{train.type}, " \
           "carriage quantity: #{train.carriage_quantity}"
    end
  end

  protected

  def number_checker
    puts 'Set train number: '
    self.number = gets.chomp
    raise 'Wrong train number!' if number !~ /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  end

  def type_checker
    puts "Set carriage type('passenger' or 'cargo'): "
    self.type = gets.chomp.to_sym
    raise 'Wrong carriage type!' until type == :cargo || type == :passenger
  end

  def carr_qty_checker
    puts 'Set carriage quantity: '
    self.carriage_quantity = gets.to_i
    raise 'Wrong carriage quantity!' until carriage_quantity.is_a?(Integer) && carriage_quantity.positive?
  end

  def sequence_checker
    puts 'Set train sequence: '
    self.sequence = gets.to_i
    raise 'Wrong train sequence!' until sequence.is_a?(Integer) && sequence.positive?
  end

  def station_name_checker
    puts 'Set station name: '
    self.name = gets.chomp
    raise 'Wrong station name!' if @name !~ /[a-z]/i
  end

  def carr_num_checker
    puts 'Set carriage number: '
    self.carriage_number = gets.to_i
    raise 'Wrong carriage number!' if carriage_number > @trains[sequence].carriages.length
  end
end
