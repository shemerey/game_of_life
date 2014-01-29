require 'spec_helper'

describe GameOfLife::Board do
  let(:height) { 50 }
  let(:width) { 40 }
  subject { described_class.new(width, height) }

  it 'should be 40x50 board by default' do
    subject.width.should ==  width
    subject.height.should == height
  end

  it 'should have #x width - 1' do
    subject.x.should == width - 1
  end

  it 'should have #y height - 1' do
    subject.y.should == height - 1
  end

  it 'should know about all cells'
end


