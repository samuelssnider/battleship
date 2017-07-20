require './lib/game_board'
require './lib/position'
require './lib/auto_position'
require './lib/message_printer'
require './lib/user'

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
    @user = User.new(@user_board, @cpu_board, @difficulty[:ship_lengths],@message_printer)
  end

  def user_turn
    @cpu_board.print_board
    @message_printer.fire_cordinates_request
    auto_pos = AutoPosition.new(@user.fire_validation)
    @cpu_board.fire!(auto_pos)
    if @cpu_board.ships.all? {|ship| ship.sunk}
      @user_victory = true
    end
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
