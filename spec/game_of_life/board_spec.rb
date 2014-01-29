require 'spec_helper'

describe GameOfLife::Board do
  let(:length) { 50 }
  let(:width) { 40 }
  subject { described_class.new(width, length) }

  it 'should be 40x50 board by default' do
    subject.width.should ==  width
    subject.length.should == length
  end

  it 'should have #x width - 1' do
    subject.x.should == width - 1
  end

  it 'should have #y length - 1' do
    subject.y.should == length - 1
  end

  it 'should know about all cells'
end


