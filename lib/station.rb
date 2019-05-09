class Station
  attr_reader :station_name, :station_zone

  def initialize(station_name, station_zone)
    @station_name = station_name
    @station_zone = station_zone
  end
end
