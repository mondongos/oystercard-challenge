
class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINUMUM_FARE = 1

  def initialize(balance= 0)
    @balance = balance
    @journey = false
  end

  def top_up(amount)
    raise "Max Limit Reached" if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in
    raise "Insufficient funds." if @balance < MINIMUM_BALANCE

    @journey = true
  end

  def touch_out
    deduct(MINUMUM_FARE)
    @journey = false
  end

  def in_journey?
    @journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
