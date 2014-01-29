# vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2:nu
require 'spec_helper'

describe GameOfLife::Cell do
  # [0,0], [1,0], [2,0], [3,0], [4,0]
  # [0,1], [1,1], [2,1], [3,1], [4,1]
  # [0,2], [1,2], [2,2], [3,2], [4,2]
  # [0,3], [1,3], [2,3], [3,3], [4,3]
  # [0,4], [1,4], [2,4], [3,4], [4,4]
  # [0,5], [1,5], [2,5], [3,5], [4,5]
  let(:board) { GameOfLife::Board.new(5, 6) }
  subject { described_class.new(double, double, board) }

  it { should be_dead }
  it { should_not be_live }

  it 'should know about position on a board' do
    cell = described_class.new(x = 10, y = 20, board)
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
    described_class.new(1,2, board).should eq(described_class.new(1,2, board))
  end


  context 'neighbours' do
    context '#cell on edge line' do #{{{
      # [0,0], [1,0], [xxx], [3,0], [4,0]
      # [0,1], [1,1], [2,1], [3,1], [4,1]
      # [0,2], [1,2], [2,2], [3,2], [4,2]
      # [xxx], [1,3], [2,3], [3,3], [xxx]
      # [0,4], [1,4], [2,4], [3,4], [4,4]
      # [0,5], [1,5], [xxx], [3,5], [4,5]
      let(:top) { described_class.new(2,0, board) }
      let(:right) { described_class.new(4,3, board) }
      let(:bottom) { described_class.new(2,5, board) }
      let(:left) { described_class.new(0,3, board) }
      let(:corner_cels) { [top, left, bottom, right] }

      it 'all edge line cells should have 5 neighbours' do
        corner_cels.each do |cell|
          cell.neighbours.should have(5).items
        end
      end
    end #}}}

    context '#corner cells should have 3 neighbours' do #{{{
      # [xxx], [1,0], [2,0], [3,0], [xxx]
      # [0,1], [1,1], [2,1], [3,1], [4,1]
      # [0,2], [1,2], [2,2], [3,2], [4,2]
      # [0,3], [1,3], [2,3], [3,3], [4,3]
      # [0,4], [1,4], [2,4], [3,4], [4,4]
      # [xxx], [1,5], [2,5], [3,5], [xxx]
      let(:left_top) { described_class.new(0,0, board) }
      let(:right_top) { described_class.new(4,0, board) }
      let(:right_bottom) { described_class.new(4,5, board) }
      let(:left_bottom) { described_class.new(0,5, board) }
      let(:corner_cels) do
        [
          left_top,
          right_top,
          right_bottom,
          left_bottom
        ]
      end

      it 'all corner cells should have 3 neighbors' do
        corner_cels.each do |cell|
          cell.neighbours.should have(3).items
        end
      end
    end #}}}

    context '#cell with all neighbours' do #{{{
      # [0,0], [1,0], [2,0], [3,0], [4,0]
      # [0,1], [1,1], [2,1], [3,1], [4,1]
      # [0,2], [1,2], [xxx], [3,2], [4,2]
      # [0,3], [1,3], [2,3], [3,3], [4,3]
      # [0,4], [1,4], [2,4], [3,4], [4,4]
      # [0,5], [1,5], [2,5], [3,5], [4,5]
      let(:cell) { described_class.new(2, 2, board) }
      it 'should have 8 neighbours' do
        cell.neighbours.should have(8).items
      end

      it 'should have cells as a neighbors' do
        cell.neighbours.each do |neighbour|
          neighbour.should be_instance_of(described_class)
        end
      end
    end #}}}
  end

  it 'Any live cell with fewer than two live neighbours dies, as if caused by under-population.'
  it 'Any live cell with two or three live neighbours lives on to the next generation.'
  it 'Any live cell with more than three live neighbours dies, as if by overcrowding.'
  it 'Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.'

end
