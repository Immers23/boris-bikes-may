require 'bike'
require 'docking_station'

describe Bike do
  it {is_expected.to respond_to :working?}

  it 'can be reported broken' do
    subject.report_broken
    expect(subject.working?).to eq(false)
  end

end
