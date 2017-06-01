class Route
  attr_accessor :stations

  def initialize(start:, finish:)
    @stations = [start, finish]
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(station)
    self.stations.delete(station)
  end

  def show_all_stations
    puts "Stations in the route:"
    self.stations.each_with_index do |station, index|
      puts "#{index}: #{station.title}"
    end
  end

  private

  def validate!
    raise "Error" if stations.first.nil?
    raise "Error" if stations.last.nil?
    raise "Error" unless stations.first.class == Station
    raise "Error" unless stations.last.class == Station
    true
  end
end
