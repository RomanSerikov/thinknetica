class Route
  attr_accessor :middle
  attr_reader   :start, :finish

  def initialize(start, finish)
    @start  = start
    @finish = finish
    @middle = []
    puts "Route created: #{self}, from: #{self.start.title} to #{self.finish.title}."
  end

  def add_station(station)
    self.middle << station
    puts "Station #{station.title} added to the route #{self}."
  end

  def delete_station(station)
    self.middle.delete(station)
    puts "Station #{station.title} removed from the route #{self}."
  end

  def show_all_stations
    puts "Stations in the route:"
    all_stations.each_with_index do |station, index|
      puts "#{index}: #{station.title}"
    end
  end

  def all_stations
    [start, middle, finish].flatten
  end
end