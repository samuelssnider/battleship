require 'pry'
class Position
  attr_reader :placement,
              :valid

  def initialize(position, length)
    @rows = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
    @placement
    @valid
    is_valid?(position, length)
  end

  def is_valid?(position, length)
    @valid = true
    input = position[0]
    column = position[1].to_i
    # if column == 0 && position[1] != "0"
    #   @valid = false
    #   puts "Please enter a letter number pair ex: b1"
    # end
    if column >= length || column < 0
      @valid = false
      puts "That is not a valid position (number[column] index out of bounds)"
    end
    letter = input
    up_letter = letter.upcase
    row = @rows.find_index(up_letter)
    if row.nil? || row >= length || row < 0
      @valid = false
      "That is not a valid position (letter[row] index out of bounds)"
    end
    if @valid
        @placement = [row, column]
    end
    @valid
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
      puts "Ship must be placed in a straight line"
    end
    r_straight || c_straight
  end

end
