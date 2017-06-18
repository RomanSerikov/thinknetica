class Train
  attr_accessor :vagons, :speed, :current_station, :route
  attr_reader :number, :type

  def initialize(number, type, vagons)
    @number = number
    @type = type
    @vagons = vagons
    @speed = 0
    @route = nil
    @current_station = nil
    puts "Train created: #{self}, number: #{self.number}, type: #{self.type}, vagons: #{self.vagons}."
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

  def add_vagon
    if speed == 0
      self.vagons += 1
      puts "Vagon added. Total vagons: #{self.vagons}"
    else
      puts "Error. You should stop to remove vagons."
    end
  end

  def remove_vagon
    if speed == 0
      if vagons > 0
        self.vagons -= 1
        puts "Vagon removed. Total vagons: #{self.vagons}"
      else
        puts "Error. No vagons in train #{self.number}"
      end
    else
      puts "Error. You should stop to remove vagons."
    end
  end

  def take_route(route)
    self.route = route.all_stations
    self.current_station = route.start
    puts "Route #{route.start.title}-#{route.finish.title} taken."
  end

  def move_next_station
    if self.current_station != self.route.last
      self.current_station = next_station
      puts "Train #{self.number} moved to station #{self.current_station.title}"
    else
      puts "Error. #{current_station.title} is the ending station."
    end
  end

  def move_back_station
    if self.current_station != self.route.first
      self.current_station = prev_station
      puts "Train #{self.number} moved to station #{self.current_station.title}"
    else
      puts "Error. #{current_station.title} is the ending station."
    end
  end

  def curr_station_index
    self.route.index(current_station)
  end

  def next_station
    self.route[curr_station_index + 1]
  end

  def prev_station
    self.route[curr_station_index - 1]
  end
end






