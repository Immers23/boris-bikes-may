require_relative 'bike'

class DockingStation

  def release_bike
    Bike.new
  end

  def dock(bike)
    @bike = bike
  end

  def bike
    @bike
  end


end
