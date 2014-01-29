require 'all'

class GameOfLife::Board
  attr_reader :width, :height

  def initialize(width = 40, height = 50)
    @width, @height = width, height
  end

  def x
    width - 1
  end

  def y
    height - 1
  end
end
