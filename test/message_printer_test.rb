require 'minitest'
require 'mintest/autorun'
require 'minitest/pride'
require './lib/message_printer'

class MessagePrinter < Minitest::Test
  def test_it_works
    mp = MessagePrinter.new
    assert mp
    assert_instance_of mp, MessagePrinter
  end
end
