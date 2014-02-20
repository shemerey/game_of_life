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

      def window_width
        Ncurses.COLS
      end

      def window_height
        Ncurses.LINES
      end

      def refresh
        Ncurses.stdscr
      end

      def draw
        if true
          to_live, to_die = [], []

          board.cells.each do |cell|
            window.move(cell.x, cell.y)
            window.addstr(cell_char(cell))

            to_live << cell if cell.will_live?
            to_die << cell if cell.will_die?
          end

          to_live.map(&:live!)
          to_die.map(&:kill!)
          sleep 0.5
        else
          window.move(window_height/2, window_width/2)
          window.addstr("press 'q' to exit")
        end
        refresh
      end

      def cell_char(cell)
        cell.live? ? "\u{25CE}": " "
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

