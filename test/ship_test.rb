require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_length_is_initialized
    s = Ship.new(2)
    assert_equal 2, s.length
  end

  def test_you_can_set_position
    s = Ship.new(2)
    s.position = 12
    assert_equal 12, s.position
  end

  def test_health_is_working
    s_one = Ship.new(3)
    s_two = Ship.new(2)
    assert_equal 3, s_one.health
    assert_equal 2, s_two.health
    s_one.hit
    assert_equal 2, s_one.health
    s_one.hit
    assert_equal 1, s_one.health
    s_one.hit
    assert_equal 0, s_one.health
  end

  def test_sink_is_working
    s_one = Ship.new(3)
    s_two = Ship.new(2)
    assert_equal 3, s_one.health
    assert_equal 2, s_two.health
    refute s_one.sunk
    s_one.hit
    s_one.hit
    s_one.hit
    assert s_one.sunk
    refute s_two.sunk
    s_two.hit
    s_two.hit
    assert s_two.sunk
  end


end
