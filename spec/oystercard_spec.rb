require 'oystercard'

describe Oystercard do

  it "has a balance" do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it "allows customer to top up" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it "raises an error if balance is over £90" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect{ subject.top_up(1) }.to raise_error "Max Limit Reached"
    end
  end

  describe 'touch functionality' do
    subject { Oystercard.new(5) }

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'allows customer to tap-in' do
      expect(subject.touch_in).to eq(true)
    end

    it 'allow customer to tap-out' do
      expect(subject.touch_out).to eq(false)
    end

    it 'checks if card is in use' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'checks if tap-out ends journey' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  describe 'balance checks' do
    it 'checks balance and raises error if balance < £1' do
      expect { subject.touch_in }.to raise_error "Insufficient funds."
    end

    it 'balance is reduced when tapping out' do
      balance_reduced = Oystercard::MINUMUM_FARE * -1
      expect { subject.touch_out }.to change{ subject.balance }.by(balance_reduced)
    end
  end
end
