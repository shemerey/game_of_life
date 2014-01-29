require "all"

class GameOfLife
  attr_reader :board

  def initialize(*options)
    @board = Board.new(20, 30)
  end

  def over?
    false
  end
end
