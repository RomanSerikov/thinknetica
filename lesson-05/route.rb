class Route
  attr_accessor :stations

  def initialize(start:, finish:)
    @stations = [start, finish]
    puts "Route created: #{self}, from: #{start.title} to #{finish.title}."
  end

  def add_station(station)
    self.stations.insert(-2, station)
    puts "Station #{station.title} added to the route #{self}."
  end

  def delete_station(station)
    self.stations.delete(station)
    puts "Station #{station.title} removed from the route #{self}."
  end

  def show_all_stations
    puts "Stations in the route:"
    self.stations.each_with_index do |station, index|
      puts "#{index}: #{station.title}"
    end
  end
end
