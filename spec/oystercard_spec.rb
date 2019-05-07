require 'oystercard'

describe Oystercard do

it "has a balance" do
  expect(subject.balance).to eq(0)
end

describe '#top_up' do
  it "allows customer to top up" do
  expect(subject).to respond_to(:top_up).with(1).argument
  end
end

end
