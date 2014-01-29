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

  it 'should be eql cells if x and y is the same' do
    described_class.new(1,2).should eq(described_class.new(1,2))
  end


  context 'neighbours' do
    #
    # [0,0], [1,0], [2,0], [3,0], [4,0]
    # [0,1], [1,1], [2,1], [3,1], [4,1]
    # [0,2], [1,2], [xxx], [3,2], [4,2]
    # [0,3], [1,3], [2,3], [3,3], [4,3]
    # [0,4], [1,4], [2,4], [3,4], [4,4]
    # [0,5], [1,5], [2,5], [3,5], [4,5]
    #
    # [2,2] =>  [1,1], [2,1], [3,1], [3,2], [3,3], [2,3], [1,3], [1,2]
    it 'should have 8 neighbours' do
      described_class.new(2,2).neighbours.should have(8).items
    end

    it 'should have neighbors' do
      described_class.new(2,2).neighbours.should be_instance_of(Array)
      described_class.new(2,2).neighbours.should_not be_empty
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
