require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/position'


class PositionTest < Minitest::Test
  def test_position_is_working
    pos = Position.new(["a1", "a2"], 4)
    assert_equal pos.placement, [0,1]
  end

end
