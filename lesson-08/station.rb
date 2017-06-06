require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid
  attr_accessor :trains
  attr_reader   :title
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(title:)
    @title = title
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def each(&block)
    @trains.each(&block)
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    puts "Trains with type #{type} on station #{title}:"
    trains.each do |train|
      puts train.number.to_s if train.type == type
    end
  end

  def show_all_trains
    puts "Trains on station #{title}:"
    trains.each do |train|
      puts "##{train.number} | type: #{train.type} | vagons: #{train.vagons.count}"
    end
  end

  private

  def validate!
    raise 'Title should not be empty' if title.nil?
  end
end
