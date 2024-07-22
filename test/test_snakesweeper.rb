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

  # def test_it_can_count_coordinate_neighbours_with_mines
  #   board = Snakesweeper::Board.generate_with_random_mines(3, 3, 9)
  # end

  def test_it_can_generate_a_coordinate
    coordinate = Snakesweeper::Coordinate.new(1, 2)

    assert_equal(coordinate.x, 1)
    assert_equal(coordinate.y, 2)
  end

  def test_it_can_compare_coordinates
    coordinate = Snakesweeper::Coordinate.new(3, 3)
    assert_equal(coordinate.x, 3)
    assert_equal(coordinate.y, 3)

    equal_coordinate = Snakesweeper::Coordinate.new(3, 3)
    assert_equal(coordinate == equal_coordinate, true)

    [
      Snakesweeper::Coordinate.new(3, 4),
      Snakesweeper::Coordinate.new(4, 3),
      Snakesweeper::Coordinate.new(1, 1)
    ].each do |other_coordinate|
      assert_equal(coordinate == other_coordinate, false)
    end
  end

  def test_it_assert_correct_coordinate_neighbours
    board = Snakesweeper::Board.generate_with_random_mines(1, 1, 10)
    coordinate = Snakesweeper::Coordinate.new(0, 1)
    assert_equal(coordinate.x, 0)
    assert_equal(coordinate.y, 1)

    neighbour1 = Snakesweeper::Coordinate.new(-1, 0)
    neighbour2 = Snakesweeper::Coordinate.new(-1, 1)
    neighbour3 = Snakesweeper::Coordinate.new(-1, 2)
    neighbour4 = Snakesweeper::Coordinate.new(0, 0)
    neighbour5 = Snakesweeper::Coordinate.new(0, 2)
    neighbour6 = Snakesweeper::Coordinate.new(1, 0)
    neighbour7 = Snakesweeper::Coordinate.new(1, 1)
    neighbour8 = Snakesweeper::Coordinate.new(1, 2)

    assert_equal(coordinate.neighbour?(board, neighbour1), false)
    assert_equal(coordinate.neighbour?(board, neighbour2), false)
    assert_equal(coordinate.neighbour?(board, neighbour3), false)
    assert_equal(coordinate.neighbour?(board, neighbour4), true)
    assert_equal(coordinate.neighbour?(board, neighbour5), false)
    assert_equal(coordinate.neighbour?(board, neighbour6), true)
    assert_equal(coordinate.neighbour?(board, neighbour7), true)
    assert_equal(coordinate.neighbour?(board, neighbour8), false)

    random_coordinate = Snakesweeper::Coordinate.new(10, 10)
    assert_equal(random_coordinate.neighbour?(board, coordinate), false)
  end

  def test_it_can_remove_off_board_neighbours
    board = Snakesweeper::Board.generate_with_random_mines(5, 5, 10)
    coordinate = Snakesweeper::Coordinate.new(0, 0)
    assert_equal(coordinate.x, 0)
    assert_equal(coordinate.y, 0)

    neighbour1 = Snakesweeper::Coordinate.new(-1, -1)
    neighbour2 = Snakesweeper::Coordinate.new(-1, 0)
    neighbour3 = Snakesweeper::Coordinate.new(-1, 1)
    neighbour4 = Snakesweeper::Coordinate.new(0, -1)
    neighbour5 = Snakesweeper::Coordinate.new(0, 1)
    neighbour6 = Snakesweeper::Coordinate.new(1, -1)
    neighbour7 = Snakesweeper::Coordinate.new(1, 0)
    neighbour8 = Snakesweeper::Coordinate.new(1, 1)

    refute_includes(coordinate.neighbours(board), neighbour1)
    refute_includes(coordinate.neighbours(board), neighbour2)
    refute_includes(coordinate.neighbours(board), neighbour3)
    refute_includes(coordinate.neighbours(board), neighbour4)
    assert_includes(coordinate.neighbours(board), neighbour5)
    refute_includes(coordinate.neighbours(board), neighbour6)
    assert_includes(coordinate.neighbours(board), neighbour7)
    assert_includes(coordinate.neighbours(board), neighbour8)

    coordinate = Snakesweeper::Coordinate.new(5, 5)
    assert_equal(coordinate.x, 5)
    assert_equal(coordinate.y, 5)

    neighbour1 = Snakesweeper::Coordinate.new(4, 4)
    neighbour2 = Snakesweeper::Coordinate.new(4, 5)
    neighbour3 = Snakesweeper::Coordinate.new(4, 6)
    neighbour4 = Snakesweeper::Coordinate.new(5, 4)
    neighbour5 = Snakesweeper::Coordinate.new(5, 6)
    neighbour6 = Snakesweeper::Coordinate.new(6, 4)
    neighbour7 = Snakesweeper::Coordinate.new(6, 5)
    neighbour8 = Snakesweeper::Coordinate.new(6, 6)

    assert_includes(coordinate.neighbours(board), neighbour1)
    assert_includes(coordinate.neighbours(board), neighbour2)
    refute_includes(coordinate.neighbours(board), neighbour3)
    assert_includes(coordinate.neighbours(board), neighbour4)
    refute_includes(coordinate.neighbours(board), neighbour5)
    refute_includes(coordinate.neighbours(board), neighbour6)
    refute_includes(coordinate.neighbours(board), neighbour7)
    refute_includes(coordinate.neighbours(board), neighbour8)
  end

  def test_it_can_calculate_neighbours
    board = Snakesweeper::Board.generate_with_random_mines(5, 5, 10)
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

    assert_includes(coordinate.neighbours(board), neighbour1)
    assert_includes(coordinate.neighbours(board), neighbour2)
    assert_includes(coordinate.neighbours(board), neighbour3)
    assert_includes(coordinate.neighbours(board), neighbour4)
    assert_includes(coordinate.neighbours(board), neighbour5)
    assert_includes(coordinate.neighbours(board), neighbour6)
    assert_includes(coordinate.neighbours(board), neighbour7)
    assert_includes(coordinate.neighbours(board), neighbour8)

    refute_includes(coordinate.neighbours(board), Snakesweeper::Coordinate.new(1, 1))
  end
end
