require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_length_is_initialized
    s = Ship.new(2)
    assert_equal 2, s.length
  end

end
