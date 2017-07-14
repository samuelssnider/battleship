require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './battleship'


class BattleshipTest < Minitest::Test

  def test_b_is_initialized
    b = Battleship.new
    assert_equal Battleship, b.class
  end


end
