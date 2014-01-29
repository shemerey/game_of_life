require 'spec_helper'

describe GameOfLife::Board do

  it 'should be 40x50 board by default' do
    subject.width.should == 40
    subject.length.should == 50
  end

end


