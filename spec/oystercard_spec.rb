require 'oystercard'

describe Oystercard do
  let(:entry_station) { :entry_station }
  let(:exit_station) { :exit_station }

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
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'allow customer to tap-out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
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

    it "sets entry station to nil on touch-out" do
      subject.touch_in
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
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

  describe 'journey details' do
    it 'checks if the entry station is provided' do
      subject.top_up(20)
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'stores entry station' do
      subject.top_up(20)
          subject.touch_in(:entry_station)

      expect(subject.entry_station).to eq(:entry_station)
    end

    it 'checks if the exit station is provided' do
      subject.top_up(20)
      subject.touch_in

      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it 'stores exit station' do
      subject.top_up(20)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)

      expect(subject.exit_station).to eq(:exit_station)
    end
  end

  describe 'journey history' do
    it 'is in stored in instance variable' do
      subject.top_up(20)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.journey_history).to eq([{:entry_station => :entry_station, :exit_station => :exit_station}])
    end
  end

end
