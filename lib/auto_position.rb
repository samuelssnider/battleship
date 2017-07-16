class AutoPosition
  attr_reader :placement,
              :row,
              :column
  def initialize(placement)
    @placement = placement
    @row = placement[0]
    @column = placement[1]
  end

  def adjacent?(oth)
    if    (self.placement[0] == (oth.placement[0] + 1)) &&
          (self.placement[1] == oth.placement[1])
      result = true
    elsif (self.placement[0] == oth.placement[0]) &&
          (self.placement[1] == (oth.placement[1] + 1))
      result = true
    elsif (self.placement[0] == oth.placement[0]) &&
          (self.placement[1] == (oth.placement[1] - 1))
      result = true
    elsif (self.placement[0] == (oth.placement[0] - 1)) &&
          (self.placement[1] == oth.placement[1])
      result = true
    else
       result = false
    end
    result
  end

end
