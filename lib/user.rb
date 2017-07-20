require './lib/game_board'
require './lib/message_printer'
require './lib/position'

class User
  def initialize(user_board, cpu_board, ship_lengths, message_printer)
    @user_board = user_board
    @cpu_board = cpu_board
    @ship_lengths = ship_lengths
    @message_printer = message_printer
    @ship_lengths.each do |length|
      place_ship(length)
    end
  end

  def place_ship(length)
    @message_printer.enter_ship_placement_cordinates(length)
    result = false
    until result == true
      user_commands = gets.chomp.split(" ")
      if user_commands.count == length
        @placement_array  = []
        user_commands.each do |user_command|
          position_checker(user_command)
        end
        if @placement_array.count == user_commands.count
          result = @user_board.place(@placement_array)
        else
          @message_printer.straight_adjacent_error_msg
        end
      else
        @message_printer.wrong_num_cordinates
      end
      unless result
        @message_printer.try_placing_again(length)
      end
    end
  end

  def wrong_num_positions(number, wrong = true)
    if wrong
      @message_printer.wrong_number_of_input_positions
    end
    gets.chomp.split(" ")
  end

  def position_checker(user_command)
    pos = Position.new(user_command, @user_board.length)
    if pos.valid
      if @placement_array.empty?
        @placement_array << pos
      elsif @placement_array.last.adjacent?(pos) && @placement_array.count <= 1
        @placement_array << pos
      else
        if  @placement_array.last.adjacent?(pos) && pos.straight?(@placement_array)
          @placement_array << pos
        end
      end
    end
  end

  def fire_validation
    made = false
    blank = true
    until made && blank
      input = gets.chomp
      pos = Position.new(input, @cpu_board.length)
      made = pos.valid
      if made
        if (@cpu_board.board[pos.placement[0]][pos.placement[1]] == "H") ||
           (@cpu_board.board[pos.placement[0]][pos.placement[1]] == "M")
          blank = false
        else
          blank = true
        end
      end
      unless made
        @message_printer.invalid_firing_position
      end
      unless blank
        @message_printer.already_fired_at
      end
    end
    pos.placement
  end

end
