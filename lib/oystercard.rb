
class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINUMUM_FARE = 1

  def initialize(balance= 0)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "Max Limit Reached" if reach_max_limit?(amount)
    @balance += amount
  end

  def touch_in(station = "")
    raise "Insufficient funds." if insufficient_fund?
    @entry_station = station
  end

  def touch_out(station = "")
    deduct(MINUMUM_FARE)
    @exit_station = station
    @journey_history << {:entry_station => @entry_station, :exit_station => @exit_station}
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def insufficient_fund?
    @balance < MINIMUM_BALANCE
  end

  def reach_max_limit?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end
end
