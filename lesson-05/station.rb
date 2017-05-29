require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_accessor :trains
  attr_reader   :title
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(title:)
    @title  = title
    @trains = []
    @@stations << self
    register_instance
    puts "Station created: #{self}, title: #{self.title}."
  end

  def take_train(train)
    self.trains << train
    puts "Train #{train.number} added to the station #{self.title}."
  end

  def send_train(train)
    self.trains.delete(train)
    puts "Train #{train.number} removed from the station #{self.title}."
  end

  def trains_by_type(type)
    puts "Trains with type #{type} on station #{self.title}:"
    self.trains.each do |train|
      puts "#{train.number}" if train.type == type
    end
  end

  def show_all_trains
    puts "Trains on station #{self.title}:"
    self.trains.each do |train|
      puts "##{train.number}, type: #{train.type}."
    end
  end
end
