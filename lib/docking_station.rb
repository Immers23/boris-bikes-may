require_relative 'bike'

class DockingStation
  DEFAULT_CAPACITY = 20

  attr_accessor :capacity
  attr_reader :bikes

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
    @working_bike = []
  end

  def dock(bike)
    fail 'Docking station full' if full?
    bikes << bike
  end

  def release_working
    fail 'No bikes avaliable' if empty? || broken?
    bikes.each do |bike|
      if bike.working?
        @working_bike.push(bike)
      end
    end
    @working_bike.pop
  end

  private

  def full?
    bikes.count >= capacity
  end

  def empty?
    bikes.empty?
  end

  def broken?
    bikes.count == 1 && !bikes[0].working?
  end

end
