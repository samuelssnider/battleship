require 'pry'
class Position
  attr_reader :placement
              :valid

  def initialize(position, length)
    rows = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
    valid = is_valid?
  end

  def is_valid?
    valid = true
    column = position[1]
    if column.to_i >= length || colunm.to_i < 0
      valid = false
      puts "That is not a valid position (number[column] index out of bounds)"
    end
    string = position[0]
    letter = string[0]
    up_letter = letter.upcase
    let_pos = rows.find_index(up_letter)
    if rows.find_index(up_letter).nil?
      valid = false
      "That is not a valid position (letter[row] index out of bounds)"
    end
      if let_pos >= length

        @placement = [let_pos, column.to_i]
      else
      end
    else
      puts
    end
    @placement
  end

  def adjacent?(oth_position)
    result = false
    if self.placement[0] == (other.placement[0] + 1) ||
       self.placement[0] == (other.placement[0] - 1) ||
       self.placement[0] == (other.placement[1] + 1) ||
       self.placement[0] == (other.placement[1] - 1)
       result = true
    end
    result
  end
end
