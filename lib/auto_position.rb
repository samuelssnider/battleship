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

  def straight?(place_set)
    r_straight = false
    c_straight = false
    r_straight = place_set.all? do |place|
      self.placement[0] == place.placement[0]
    end
    c_straight = place_set.all? do |place|
      self.placement[1] == place.placement[1]
    end
    unless r_straight || c_straight
    end
    r_straight || c_straight
  end

end
