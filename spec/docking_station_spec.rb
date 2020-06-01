require 'docking_station'
require 'bike'

describe DockingStation do

  let(:bike) { double(:bike) }
  let(:bike2) { double(:bike) }
  let(:broken_bike) { double(:bike) }
  let(:subject) { described_class.new }

  it { is_expected.to respond_to :release_working }

  it { is_expected.to respond_to :bikes }

  it 'docks something' do
    expect(subject.dock(bike)). to eq [bike]
  end

  it 'returns docked bikes' do
    subject.dock(bike)
    expect(subject.bikes). to eq [bike]
  end

  describe '#release_working' do
    it 'releases a bike' do
      allow(bike).to receive(:working?).and_return(true)
      subject.dock(bike)
      expect(subject.release_working).to eq bike
    end

    it 'raises an error when docking station to release a bike when empty' do
      expect { subject.release_working }.to raise_error 'No bikes avaliable'
    end

    it 'returns only the working bikes when multiple bikes are docked and released' do
      # station = DockingStation.new
      allow(bike).to receive(:working?).and_return(true)
      allow(broken_bike).to receive(:working?).and_return(false)
      allow(bike2).to receive(:working?).and_return(true)
      subject.dock(bike)
      subject.dock(broken_bike)
      subject.dock(bike2)
      subject.release_working
      expect(subject.release_working).to eq bike2
    end

    it 'only releases working bikes when dock contains only broken bikes' do
      allow(bike).to receive(:working?).and_return(false)
      subject.dock(bike)
      expect { subject.release_working }.to raise_error 'No bikes avaliable'
    end

    it 'only releases working bikes when dock contains 2 bikes with one broken bikes' do
      allow(broken_bike).to receive(:working?).and_return(false)
      allow(bike).to receive(:working?).and_return(true)
      subject.dock(broken_bike)
      subject.dock(bike)
      expect(subject.release_working).to eq bike
    end
  end

  describe '#dock' do

    it { is_expected.to respond_to(:dock).with(1).argument }

    it 'raises an error when the docking station is full with 20 bikes' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock bike }
      expect { subject.dock bike }.to raise_error 'Docking station full'
    end

    it 'has a default capacity of 20 when initialized without an argument' do
      subject.capacity.times { subject.dock bike }
      expect { subject.dock bike }.to raise_error 'Docking station full'
    end
  end
end
