require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/position'


class PositionTest < Minitest::Test
  def test_position_is_working
    pos = Position.new(["a1"], 4)
    assert_equal  [0,1], pos.placement
    assert pos.placement
    pos = Position.new(["d3"], 4)
    assert_equal  [3,3], pos.placement
  end

  def test_invalid_positions
    pos = Position.new(["e1"], 4)
    refute pos.valid
    assert_nil pos.placement
    pos_2 = Position.new(["a4"], 3)
    refute pos_2.valid
    assert_nil pos_2.placement
    pos_3 = Position.new(["l12"], 12)
    refute pos_2.valid
    assert_nil pos_2.placement
  end

end
