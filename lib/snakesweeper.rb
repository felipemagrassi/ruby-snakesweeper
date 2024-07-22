# frozen_string_literal: true

require_relative 'snakesweeper/version'

require 'readline'

module Snakesweeper
  class Error < StandardError; end

  module_function def play(...)
    board = Board.generate_with_random(...)
    game = Game.new(board)
  end

  class Game
    def initialize(board)
      @board = board
      @revealed = Array.new(board.height * board.width, nil)
    end
  end

  class Board < Data.define(:width, :height, :mines)
    def self.generate_with_random_mines(width, height, mines_count)
      board_cartesian_product = Enumerator.product(width.times, height.times)
                                          .map { |x, y| Coordinate.new(x, y) }
      mines = board_cartesian_product.sample(mines_count)
      new(width, height, mines)
    end
  end

  class Coordinate < Data.define(:x, :y)
    def neighbour?(coordinate)
      return true if (x - coordinate.x).abs <= 1 && (y - coordinate.y).abs <= 1

      false
    end
  end
end
