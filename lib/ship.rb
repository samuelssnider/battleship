class Ship
  attr_reader   :length,
                :health,
                :sunk
  attr_accessor :position
  def initialize(length)
    @length = length
    @position = []
    @health = length
    @sunk = false
  end

  def hit
    @health -= 1
    if @health == 0
      @sunk = true
    end
  end



end
