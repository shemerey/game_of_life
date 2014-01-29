require 'all'

class GameOfLife::Cell
  attr_accessor :x, :y, :status

  def initialize(x, y, status = :dead)
    self.x, self.y, self.status = x, y, status
  end

  def neighbours
    [
     self.class.new(1,2),
     self.class.new(1,2),
     self.class.new(1,2),
     self.class.new(1,2),
     self.class.new(1,2),
     self.class.new(1,2),
     self.class.new(1,2),
     self.class.new(1,2),
    ]
  end

  def live!
    self.status = :live
  end

  def kill!
    self.status = :dead
  end

  def live?
    not dead?
  end

  def dead?
    :dead == self.status
  end
end
