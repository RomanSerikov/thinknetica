class PassengerTrain < Train
  def initialize(number:)
    @type = :pass
    super
  end
end