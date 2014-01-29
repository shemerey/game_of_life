require 'all'

class GameOfLife::Board
  attr_reader :width, :length

  def initialize(width = 40, length = 50)
    @width, @length = width, length
  end
end
