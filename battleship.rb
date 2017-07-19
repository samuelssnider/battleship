require './lib/game_board'
require './lib/position'
require './lib/auto_position'
require './lib/message_printer'

class Battleship
  def initialize
    @user_victory = false
    @cpu_victory = false
    runner
  end

  def runner
    timer
    @message_printer = MessagePrinter.new
    welcome_msg
    unless @quit
      computer_done_placing_msg
      user_setup
      @board_tiles = build_board_tiles
      until @cpu_victory || @user_victory
        user_turn
        cpu_turn
      end
      victory_readout
    else
      puts "Goodbye"
    end
  end

  def timer
    @start_time = Time.now
  end


  def build_board_tiles
    board = @user_board.board
    board_tiles = []
    board.each_with_index do |row, index|
      row.each_with_index do |tile,inner_index|
        board_tiles << AutoPosition.new([index, inner_index])
      end
    end
    board_tiles
  end

  def welcome_msg
    @message_printer.welcome_message
    user_command = ""
    until user_command == "p"
      user_command = gets.chomp
      case user_command
      when "p"
        modes
      when "i"
        @message_printer.instructions
      when "q"
        @quit = true
        break
      else
        @message_printer.play_instr_quit_msg(user_command)
      end
    end
  end


  def modes
    @message_printer.modes_msg
    user_command = ""
    until (user_command == "b") || (user_command == "i") || (user_command == "e")
      user_command = gets.chomp
      case user_command
      when "b"
        @difficulty = {:diff => "Beginner", :length => 4,
                       :ship_lengths => [2, 3],:last => "D4"}
        computer_ship_placement
      when "i"
        @difficulty = {:diff => "Intermediate", :length => 8,
                       :ship_lengths => [2, 3, 4], :last => "H8" }
        computer_ship_placement #Intermediate mode
      when "e"
        @difficulty = {:diff => "Expert", :length => 12,
                       :ship_lengths => [2, 3, 4, 5], :last => "L12"}
        computer_ship_placement  #Expert mode
      else
        @message_printer.modes_input_err(user_command)
      end
    end
  end

  def computer_ship_placement
    @cpu_board = GameBoard.new(@difficulty, true)
  end

  def computer_done_placing_msg
    @message_printer.cpu_setup_complete_msg(@difficulty[:last])
  end


  def user_setup
    @user_board = GameBoard.new(@difficulty)
    @difficulty[:ship_lengths].each do |length|
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


  def user_turn
    @cpu_board.print_board
    @message_printer.fire_cordinates_request
    auto_pos = AutoPosition.new(fire_validation.placement)
    @cpu_board.fire!(auto_pos)
    if @cpu_board.ships.all? {|ship| ship.sunk}
      @user_victory = true
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
        if (@cpu_board.board[pos.placement[0]][pos.placement[1]] == "H") ||  (@cpu_board.board[pos.placement[0]][pos.placement[1]] == "M")
          blank = false
        else
          blank = true
        end
      end
    end
    unless made
      @message_printer.invalid_firing_position
    end
    unless blank
      @message_printer.already_fired_at
    end
    pos
  end

  def cpu_turn
    spot = @board_tiles.sample
    @board_tiles.delete(spot)
    @user_board.fire!(spot)
    @user_board.print_board
    if @user_board.ships.all? {|ship| ship.sunk}
      @cpu_victory = true
    end
  end

  def victory_readout
    if @user_victory && @cpu_victory
      @message_printer.tie_game(@cpu_board.shots)
    elsif @user_victory
      @message_printer.user_victory(@cpu_board.shots)
    else
      @message_printer.cpu_victory(@user_board.shots)
    end
    @message_printer.time_and_thankyou((Time.now - @start_time).round(2))
  end


end

if __FILE__ == $0
  b = Battleship.new
end
