require 'pry'
class Position
  attr_reader :placement,
              :valid

  def initialize(position, length)
    @rows = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
    @placement
    @validv= is_valid?(position, length)
  end

  def is_valid?(position, length)
    @valid = true
    if position[1].to_i == 0 && position[1] != "0"
      @valid = false
      puts "Please enter a number a$$"
    end
    column = position[1].to_i
    if column >= length || column < 0
      @valid = false
      puts "That is not a valid position (number[column] index out of bounds)"
    end
    string = position[0]
    letter = string[0]
    up_letter = letter.upcase
    row = @rows.find_index(up_letter)
    if row.nil? || row >= length || row < 0
      @valid = false
      "That is not a valid position (letter[row] index out of bounds)"
    end
    if @valid
        @placement = [row, column.to_i]
    end
    @placement
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

end
