# frozen_string_literal: true

# Split the program into separate classes (each class in a separate file)
# Divide trains into two types PassengerTrain and CargoTrain, make a parent
# for the classes, which will contain common methods and properties
# Determine which methods can be placed in private / protected and move them
# into such a section. In a comment to the method, justify why
# it was moved to private / protected
# Cars are now divided into freight and passenger (separate classes).
# Only passenger trains can be attached to a passenger train,
# and freight trains can be attached to a freight train. When adding
# a carriage to a train, the carriage object should be saved in the train's
# internal array, unlike the previous task, where we counted only the number
# of cars. The constructor parameter "number of cars" can be deleted.
# Complicated task: create a program in the main.rb file that will allow
# the user through a text interface to do the following:
#      - Create stations
#      - Create trains
#      - Add wagons to the train
#      - Disconnect wagons from the train
#      - Place trains at the station
#      - View station list and train list at station

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
