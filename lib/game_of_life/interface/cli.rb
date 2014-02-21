require 'all'

class GameOfLife
  class Interface
    class Cli
      attr_reader :game

      def initialize(game)
        @game = game

        Ncurses.initscr                   # initialize ncurses
        Ncurses.cbreak                    # provide unbuffered input
        Ncurses.noecho                    # turn off input echoing
        Ncurses.nonl                      # turn off newline translation
        Ncurses.stdscr.intrflush(false)   # turn off flush-on-interrupt
        Ncurses.stdscr.keypad(true)       # turn on keypad mode
        Ncurses.stdscr.nodelay(true)      # get nonblocked user input
      end

      def window
        Ncurses.stdscr
      end

      def refresh
         Ncurses.refresh
      end

      def y_margin
        3
      end

      def x_margin
        6
      end

      def draw
        to_live, to_die = [], []

        window.box(0, 0)
        window.move(0, 0)
        window.addstr("Press 'q' to exit")

        board.cells.each do |cell|
          window.move(cell.y + y_margin, (cell.x * 2) + x_margin)
          window.addstr(cell_char(cell))

          to_live << cell if cell.will_live?
          to_die << cell if cell.will_die?
        end

        to_live.map(&:live!)
        to_die.map(&:kill!)
        sleep 0.3
        refresh
      end

      def cell_char(cell)
        cell.live? ? "\u{1f4d7} ": "  "
        # http://en.wikipedia.org/wiki/Box-drawing_character
      end

      def board
        @game.board
      end

      def exit?
        %w[q Q].map(&:ord).include? Ncurses.stdscr.getch
      end

      def exit
        Ncurses.echo
        Ncurses.nocbreak
        Ncurses.nl
        Ncurses.endwin
      end

    end
  end
end

