require_relative 'validation'
require_relative 'acessors'
require_relative 'station'

class Route
  include Validation
  include Acessors

  attr_accessor :stations
  attr_reader   :start_station, :finish_station

  validate :start_station, :type, Station
  validate :finish_station, :type, Station

  def initialize(start:, finish:)
    @start_station  = start
    @finish_station = finish
    validate!
    @stations = [start, finish]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def show_all_stations
    puts 'Stations in the route:'
    stations.each_with_index do |station, index|
      puts "#{index}: #{station.title}"
    end
  end
end
