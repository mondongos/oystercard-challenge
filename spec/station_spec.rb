require 'station'

describe Station do
  let(:station_name) { :station_name }
  let(:station_zone) { :station_zone }
  subject { Station.new(:station_name, :station_zone) }

  it 'has a name' do
    expect(subject.station_name).to eq(:station_name)
  end

  it 'has a zone' do
    expect(subject.station_zone).to eq(:station_zone)
  end
end
