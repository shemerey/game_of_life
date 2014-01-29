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
    expect {
      subject.live!
    }.to change{ subject.live? }.from(false).to(true)
  end

  it 'become a dead cell if we kill it' do
    subject.live!

    expect {
      subject.kill!
    }.to change{ subject.live? }.from(true).to(false)
  end


  context 'neighbours' do
    xit 'should have neighbors' do
      subject.neighbours.should be_instance_of(Array)
      subject.neighbours.should_not be_empty
    end

    xit 'should have cells as a neighbors' do
      subject.neighbours.map(&:class).all?{|cell_class| cell_class == GameOfLife::Cell }.should be_true
      subject.neighbours.each do |neighbour|
        neighbour.should be_instance_of(described_class)
      end
    end
  end

  it 'Any live cell with fewer than two live neighbours dies, as if caused by under-population.'
  it 'Any live cell with two or three live neighbours lives on to the next generation.'
  it 'Any live cell with more than three live neighbours dies, as if by overcrowding.'
  it 'Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.'

end
