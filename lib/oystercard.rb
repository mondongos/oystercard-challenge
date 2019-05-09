
class Oystercard
  attr_reader :balance, :entry_station
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINUMUM_FARE = 1

  def initialize(balance= 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise "Max Limit Reached" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station= '')
    raise "Insufficient funds." if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MINUMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
