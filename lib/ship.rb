class Ship
  attr_reader   :length
  attr_accessor :position
  def initialize(length)
    @length = length
    @position = []
  end
end
