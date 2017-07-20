require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/user'

class UserTest < Minitest::Test
  def test_it_is_instance_of_itself
    hash ={:diff => "Beginner", :length => 4,
           :ship_lengths => [2, 3],:last => "D4"}
    user = User.new(GameBoard.new(hash), GameBoard.new(hash), [2,3], MessagePrinter.new)
    assert_instance_of User, user
  end
end
