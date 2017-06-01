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
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
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

  private

  def validate!
    raise "Title should not be empty" if title.nil?  
    true
  end
end
