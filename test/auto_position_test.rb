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

  def test_two_positions_are_adjacent
    ap_one = AutoPosition.new([1,1])
    ap_two = AutoPosition.new([2,1])
    assert ap_one.adjacent?(ap_two)
  end
end
