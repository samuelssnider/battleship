require 'pry'
class Position
  attr_reader :placement,
              :valid

  def initialize(position, length)
    @rows = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
    @placement
    @valid = is_valid?(position, length)
  end

  def is_valid?(position, length)
    @valid = true
    column = position[1]
    if column.to_i >= length || column.to_i < 0
      @valid = false
      puts "That is not a valid position (number[column] index out of bounds)"
    end
    string = position[0]
    letter = string[0]
    up_letter = letter.upcase
    let_pos = @rows.find_index(up_letter)
    if let_pos.nil? || let_pos >= length || let_pos < 0
      @valid = false
      "That is not a valid position (letter[row] index out of bounds)"
    end
    if @valid
        @placement = [let_pos, column.to_i]
    end
    @placement
    @valid
  end

  def adjacent?(oth_position)
    result = false
    if self.placement[0] == (oth_position.placement[0] + 1) ||
       self.placement[0] == (oth_position.placement[0] - 1) ||
       self.placement[1] == (oth_position.placement[1] + 1) ||
       self.placement[1] == (oth_position.placement[1] - 1)
       result = true
    end
    result
  end

end
