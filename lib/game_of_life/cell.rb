require 'all'

class GameOfLife
  class Cell
    attr_accessor :x, :y, :status

    def self.find(x, y, board)
      @collection ||= {}
      @collection["#{x}_#{y}_#{board}"] ||= new(x, y, board)
    end

    def initialize(x, y, board)
      self.status = :dead
      self.x = x
      self.y = y
      @board = board
    end
    private_class_method :new

    def x
      @x
    end

    def y
      @y
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
      self
    end

    def kill!
      self.status = :dead
      self
    end

    def live?
      not dead?
    end

    def dead?
      :dead == self.status
    end

    def will_live?
      live_neignbourse = neighbours.count(&:live?)

      if live?
        return true if (live_neignbourse == 2 || live_neignbourse == 3)
      else
        return true if live_neignbourse == 3
      end

      false
    end

    def will_die?
      not will_live?
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
              collection << self.class.find(x, y, board)
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
end
