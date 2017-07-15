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

end
