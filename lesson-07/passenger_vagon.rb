class PassengerVagon < Vagon
  attr_reader :seats, :passengers

  def initialize(seats:)
    @type       = :pass
    @seats      = seats
    @passengers = 0
  end

  def occupy_seat!
    @passengers += 1 unless self.free_seats.zero?
  end

  def occupied_seats
    @passengers
  end

  def free_seats
    self.seats - self.passengers
  end
end
