class CargoTrain < Train
  validate :number, :format, NUMBER_FORMAT

  def initialize(number:)
    @type = :cargo
    super
  end
end
