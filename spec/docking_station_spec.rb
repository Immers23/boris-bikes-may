require 'docking_station'
require 'bike'

describe DockingStation do

  it { is_expected.to respond_to :release_bike }

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

  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'raises an error when docking station to release a bike when empty' do
      expect { subject.release_bike }.to raise_error 'No bikes avaliable'
    end

    it 'only releases working bikes' do
      bike = Bike.new
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error 'No bikes avaliable'
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
