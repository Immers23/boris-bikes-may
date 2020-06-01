require 'docking_station'
require 'bike'

describe DockingStation do

  it { is_expected.to respond_to :release_working }

  it { is_expected.to respond_to :bikes }

  it 'docks something' do
    bike = Bike.new
    expect(subject.dock(bike)). to eq [bike]
  end

  it 'returns docked bikes' do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.bikes). to eq [bike]
  end

  describe '#release_working' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_working).to eq bike
    end

    it 'raises an error when docking station to release a bike when empty' do
      expect { subject.release_working }.to raise_error 'No bikes avaliable'
    end

    it 'returns only the working bikes when multiple bikes are docked and released' do
      station = DockingStation.new
      bike = Bike.new
      broken_bike = Bike.new
      bike2 = Bike.new
      broken_bike2 = Bike.new
      broken_bike.report_broken
      broken_bike2.report_broken
      station.dock(bike)
      station.dock(broken_bike)
      station.dock(bike2)
      station.dock(broken_bike2)
      station.release_working
      expect(station.release_working).to eq bike2
    end

    it 'only releases working bikes when dock contains only broken bikes' do
      bike = Bike.new
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_working }.to raise_error 'No bikes avaliable'
    end


  end

  describe '#dock' do

    it { is_expected.to respond_to(:dock).with(1).argument }

    it 'raises an error when the docking station is full with 20 bikes' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock Bike.new }
      expect { subject.dock Bike.new }.to raise_error 'Docking station full'
    end

    it 'has a default capacity of 20 when initialized without an argument' do
      subject.capacity.times { subject.dock Bike.new}
      expect { subject.dock Bike.new }.to raise_error 'Docking station full'
    end
  end
end
