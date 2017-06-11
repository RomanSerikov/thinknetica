class PassengerTrain < Train
  validate :number, :format, NUMBER_FORMAT

  def initialize(number:)
    @type = :pass
    super
  end
end
