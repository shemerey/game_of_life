require 'all'

class GameOfLife::Cell
  attr_accessor :x, :y

  def initialize(x, y)
    self.x, self.y = x, y
  end

  def live?
    not dead?
  end

  def dead?
    true
  end
end
