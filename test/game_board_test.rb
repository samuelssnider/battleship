require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './battleship'

class GameBoardTest < Minitest::Test
  def test_board_is_initialized_correctly
    gb = GameBoard.new
    gb.print_board
    assert_equal [" ", " ", " ", " "],  gb.d
    assert_equal [gb.a, gb.b, gb.c, gb.d], gb.board
  end
end
