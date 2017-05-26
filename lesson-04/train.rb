class Train
  attr_accessor :vagons, :speed, :current_station_index, :route
  attr_reader :number, :type

  def initialize(number:)
    @number = number
    @speed  = 0
    @route  = nil
    @current_station_index = nil
    @vagons = []
    puts "Train created: #{self}, number: #{self.number}, type: #{self.type}."
  end

  def speed_up
    self.speed += 10
    puts "Speed increased. Current speed: #{self.speed}."
  end

  def speed_down
    if speed > 0
      self.speed -= 10
      puts "Speed decreased. Current speed: #{self.speed}."
    else
      puts "Error. The train #{self.number} stand still."
    end
  end

  def stop
    self.speed = 0
    puts "Train stopped. Current speed: #{self.speed}."
  end

  def add_vagon(vagon)
    if speed.zero?
      if vagon.type == self.type
        self.vagons << vagon
        puts "Vagon #{vagon} added."
      else
        puts "Error. Vagon type is wrong."
      end
    else
      puts "Error. You should stop to remove vagons."
    end
  end

  def remove_vagon(vagon)
    if speed.zero?
      if self.vagons.delete(vagon)
        puts "Vagon #{vagon} removed."
      else
        puts "Error. No such vagon in train #{self.number}"
      end
    else
      puts "Error. You should stop to remove vagons."
    end
  end

  def take_route(route)
    self.route = route
    self.current_station_index = 0
    self.route.stations.first.take_train(self)
    puts "Route #{route.stations.first.title}---#{route.stations.last.title} taken."
  end

  def move_next_station
    if self.current_station_index == self.route.stations.size - 1
      puts "Error. #{current_station.title} is the ending station."
    else
      current_station.send_train(self)
      self.current_station_index += 1
      current_station.take_train(self)
      puts "Train #{self.number} moved to station #{current_station.title}."
    end
  end

  def move_back_station
    if self.current_station_index == 0
      puts "Error. #{current_station.title} is the ending station."
    else
      current_station.send_train(self)
      self.current_station_index -= 1
      current_station.take_train(self)
      puts "Train #{self.number} moved to station #{current_station.title}."
    end
  end

  def current_station
    self.route.stations[current_station_index]
  end
end






