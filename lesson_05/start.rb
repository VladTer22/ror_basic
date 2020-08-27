# frozen_string_literal: true

# User interface
module Start
  attr_accessor :action

  def intro
    message = "1 - Create station\n2 - Create train\n3 - Attach carriage\n" \
              "4 - Unhook carriage\n5 - Place train at the station\n" \
              "6 - List stations\n7 - Trains on stations\n0 - Exit"
    puts message

    loop do
      puts 'Choose action: '
      self.action = gets.to_i
      train_cases
      station_cases
    end
  end

  def train_cases
    case action
    when 2
      create_train
    when 3
      attach_carriage
    when 4
      unhook_carriage
    when 0
      exit
    end
  end

  def station_cases
    case action
    when 1
      create_station
    when 5
      place_train
    when 6
      all_stations
    when 7
      placed_trains
    end
  end
end
