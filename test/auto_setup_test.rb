require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_board'
require './lib/auto_setup'

class AutoSetupTest < Minitest::Test

  def test_auto_setup_test
    gb = GameBoard.new(true)
    as = AutoSetup.new(gb.board, gb.ships, gb.length)
    assert_equal GameBoard.new.board, gb.board
  end

end
