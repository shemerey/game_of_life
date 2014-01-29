require 'all'

class GameOfLife::Cell
  attr_accessor :x, :y, :status

  def initialize(x, y, board)
    self.status, self.x, self.y, @board = :dead, x, y, board
  end

  def neighbours
    (
      top_side_neighbours +
      right_side_neighbours +
      bottom_side_neighbours +
      left_side_neighbours
    ).uniq do |cell|
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
    def board
      @board
    end

    def get_neighbourse_for_range(x_range, y_range)
      collection = []
      x_range.each do |x|
        y_range.each do |y|
          if (0..board.x).include?(x) && (0..board.y).include?(y)
            collection << self.class.new(x, y, board)
          end
        end
      end
      collection
    end

    def top_side_neighbours
      x_range = (x-1)..(x+1) # top x
      y_range = [y + 1]      # top y
      get_neighbourse_for_range(x_range, y_range)
    end

    def left_side_neighbours
      x_range = [x - 1]      # left x
      y_range = (y-1)..(y+1) # left y
      get_neighbourse_for_range(x_range, y_range)
    end

    def right_side_neighbours
      x_range = [x + 1]      # right x
      y_range = (y-1)..(y+1) # right y
      get_neighbourse_for_range(x_range, y_range)
    end

    def bottom_side_neighbours
      x_range = (x-1)..(x+1) # bottom x
      y_range = [y - 1]      # bottom y
      get_neighbourse_for_range(x_range, y_range)
    end
end
