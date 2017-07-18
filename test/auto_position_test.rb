require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/auto_position'
require 'pry'

class AutoPositionTest < Minitest::Test
  def test_it_is_initialized_correctly
    ap = AutoPosition.new([0,1])
    assert_equal [0,1], ap.placement
    assert_equal 0, ap.row
    assert_equal 1, ap.column
  end

  def test_three_positions_are_adjacent
    ap_one = AutoPosition.new([1,1])
    ap_two = AutoPosition.new([2,1])
    ap_three = AutoPosition.new([2,2])
    assert ap_one.adjacent?(ap_two)
    assert ap_two.adjacent?(ap_three)
    refute ap_one.adjacent?(ap_one)
  end

  def test_two_positions_arent_adjacent
    ap_one = AutoPosition.new([1,1])
    ap_two = AutoPosition.new([3,1])
    refute ap_one.adjacent?(ap_two)
  end

  def test_straight
    ap_one = AutoPosition.new([1,1])
    ap_two = AutoPosition.new([2,1])
    ap_three = AutoPosition.new([2,2])
    ap_four = AutoPosition.new([2,3])
    ap_five = AutoPosition.new([3,1])
    two3_set = [ap_two, ap_three]
    one2_set = [ap_one, ap_two]
    assert ap_four.straight?(two3_set)
    assert ap_five.straight?(one2_set)
    refute ap_five.straight?(two3_set)
    refute ap_four.straight?(one2_set)
  end


end
