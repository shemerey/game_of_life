require 'spec_helper'

describe GameOfLife::Cell do

  subject { described_class.new(double, double) }

  it { should be_dead }
  it { should_not be_live }

  it 'should know about position on a board' do
    cell = described_class.new(x = 10, y = 20)
    cell.x.should == 10
    cell.y.should == 20
  end

  it 'become a dead cell if we kill it' do
    subject.live!

    expect {
      subject.kill!
    }.to change { subject.live? }.from(true).to(false)
  end

  it 'Any live cell with fewer than two live neighbours dies, as if caused by under-population.'
  it 'Any live cell with two or three live neighbours lives on to the next generation.'
  it 'Any live cell with more than three live neighbours dies, as if by overcrowding.'
  it 'Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.'

end
