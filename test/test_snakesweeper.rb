# frozen_string_literal: true

require 'test_helper'

class TestSnakesweeper < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Snakesweeper::VERSION
  end

  def test_it_does_something_useful
    assert true
  end

  def test_it_can_generate_a_game
    board = Snakesweeper::Board.generate_with_random_mines(10, 10, 1)
    game = Snakesweeper::Game.new(board)

    assert_kind_of(Snakesweeper::Game, game)
  end

  def test_it_can_generate_a_board
    board = Snakesweeper::Board.generate_with_random_mines(10, 10, 1)

    assert_equal(board.width, 10)
    assert_equal(board.height, 10)

    board.mines.each do |mine|
      assert_kind_of(Snakesweeper::Coordinate, mine)
    end
  end

  def test_it_can_generate_a_coordinate
    coordinate = Snakesweeper::Coordinate.new(1, 2)

    assert_equal(coordinate.x, 1)
    assert_equal(coordinate.y, 2)
  end

  def test_it_assert_correct_coordinate_neighbours
    coordinate = Snakesweeper::Coordinate.new(3, 3)
    assert_equal(coordinate.x, 3)
    assert_equal(coordinate.y, 3)

    neighbour1 = Snakesweeper::Coordinate.new(2, 4)
    neighbour2 = Snakesweeper::Coordinate.new(2, 3)
    neighbour3 = Snakesweeper::Coordinate.new(2, 2)
    neighbour4 = Snakesweeper::Coordinate.new(3, 2)
    neighbour5 = Snakesweeper::Coordinate.new(3, 4)
    neighbour6 = Snakesweeper::Coordinate.new(4, 2)
    neighbour7 = Snakesweeper::Coordinate.new(4, 3)
    neighbour8 = Snakesweeper::Coordinate.new(4, 4)

    assert_equal(neighbour1.neighbour?(coordinate), true)
    assert_equal(neighbour2.neighbour?(coordinate), true)
    assert_equal(neighbour3.neighbour?(coordinate), true)
    assert_equal(neighbour4.neighbour?(coordinate), true)
    assert_equal(neighbour5.neighbour?(coordinate), true)
    assert_equal(neighbour6.neighbour?(coordinate), true)
    assert_equal(neighbour7.neighbour?(coordinate), true)
    assert_equal(neighbour8.neighbour?(coordinate), true)

    random_coordinate = Snakesweeper::Coordinate.new(10, 10)
    assert_equal(random_coordinate.neighbour?(coordinate), false)
  end
end
