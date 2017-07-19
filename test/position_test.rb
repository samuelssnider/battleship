require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/position'


class PositionTest < Minitest::Test
  def test_position_is_working
    pos = Position.new("a1", 4)
    # assert_equal  [0,1], pos.placement
    assert pos.placement
    pos_2 = Position.new("d3", 4)
    assert_equal  [3,2], pos_2.placement
  end

  def test_invalid_positions
    pos = Position.new("e1", 4)
    refute pos.valid
    assert_nil pos.placement
    pos_2 = Position.new("a4", 3)
    refute pos_2.valid
    assert_nil pos_2.placement
    pos_3 = Position.new("l13", 12)
    refute pos_2.valid
    assert_nil pos_2.placement
    # pos_4 = Position.new([""])
  end

  def test_adjacent_is_working
    pos_1 = Position.new("b1", 4)
    pos_2 = Position.new("b2", 4)
    pos_3 = Position.new("a1", 4)
    pos_4 = Position.new("b3", 4)
    assert pos_2.adjacent?(pos_1)
    assert pos_1.adjacent?(pos_3)
    refute pos_2.adjacent?(pos_3)
    assert pos_4.adjacent?(pos_2)
    refute pos_4.adjacent?(pos_3)
    refute pos_4.adjacent?(pos_1)
  end

  def test_straight_is_working
    pos_1 = Position.new("b1", 4)
    pos_2 = Position.new("b2", 4)
    pos_3 = Position.new("a1", 4)
    pos_4 = Position.new("b3", 4)
    pos_5 = Position.new("c1", 4)
    one2_set= [pos_1, pos_2]
    three1_set =[pos_3, pos_1]
    assert pos_4.straight?(one2_set)
    assert pos_5.straight?(three1_set)
    refute pos_5.straight?(one2_set)
    refute pos_4.straight?(three1_set)
  end
end
