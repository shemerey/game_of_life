require "all"

class GameOfLife
  attr_reader :board

  def initialize(x, y)
    @board = Board.new(x, y)
  end

  def over?
    false
  end
end
