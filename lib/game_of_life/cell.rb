require 'all'

class GameOfLife::Cell
  attr_accessor :x, :y, :status

  def initialize(x, y, status = :dead)
    self.x, self.y, self.status = x, y, status
  end

  def neighbours
    (top_side_neighbours + right_side_neighbours + bottom_side_neighbours + left_side_neighbours).uniq do |cell|
      [cell.x, cell.y]
    end
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

  def ==(other)
    x == other.x && y == other.y
  end

  private
    def top_side_neighbours
      top_x = (x-1)..(x+1) # top x
      top_y = [y + 1]
      top = []

      top_x.each do |x|
        top_y.each do |y|
          top << self.class.new(x, y)
        end
      end

      top
    end

    def left_side_neighbours
      left_x = [x - 1]
      left_y = (y-1)..(y+1) # left y
      left = []

      left_x.each do |x|
        left_y.each do |y|
          left << self.class.new(x, y)
        end
      end

      left
    end

    def right_side_neighbours
      right_x = [x + 1]
      right_y = (y-1)..(y+1) # right y
      right = []

      right_x.each do |x|
        right_y.each do |y|
          right << self.class.new(x, y)
        end
      end

      right
    end

    def bottom_side_neighbours
      bottom_x = (x-1)..(x+1) # bottom x
      bottom_y = [y - 1]
      bottom = []

      bottom_x.each do |x|
        bottom_y.each do |y|
          bottom << self.class.new(x, y)
        end
      end

      bottom
    end
end
