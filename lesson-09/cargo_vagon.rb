class CargoVagon < Vagon
  attr_reader :capacity, :freight

  def initialize(capacity:)
    @type     = :cargo
    @capacity = capacity
    @freight  = 0
  end

  def add_freight(volume)
    @freight += volume unless empty_space < volume
  end

  def filled_space
    @freight
  end

  def empty_space
    capacity - freight
  end
end
