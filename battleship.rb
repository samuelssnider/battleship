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
    message_printer = MessagePrinter.new
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
    puts "Welcome to BATTLESHIP \n \n"
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    user_command = ""
    until user_command == "p"
      user_command = gets.chomp
      case user_command
      when "p"
        modes
      when "i"
        puts "This is a computer version of the tabletop game BATTLESHIP."
        puts "The player begins by placing his/her ships on the board."
        puts "After setup, you and the computer take turns firing at each other"
        puts "until all ships on either side have been sunk. The first player to"
        puts "sink the others' entire fleet wins the game!"
      when "q"
        @quit = true
        break
      else
        puts  "\nYou typed '#{user_command}', sorry, that is not a valid command."
        puts  "Please try (p) - play, (i) - instructions, (q) - quit."
      end
    end
  end


  def modes
    puts  "Please enter difficulty (b) - beginner, (i) - intermediate, (e) - expert"
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
        puts  "\nYou typed '#{user_command}', sorry, that is not a valid command."
        puts  "Please try (b) - begginer, (i) - intermediate, (e) - expert."
      end
    end
  end

  def computer_ship_placement
    @cpu_board = GameBoard.new(@difficulty, true)
  end

  def computer_done_placing_msg
    puts "I have laid out my ships on the grid."
    puts "You now need to layout your two ships."
    puts "The first is two units long and the"
    puts "second is three units long."
    puts "The grid has A1 at the top left and #{@difficulty[:last]} at the bottom right."
  end


  def user_setup
    @user_board = GameBoard.new(@difficulty)
    @difficulty[:ship_lengths].each do |length|
      place_ship(length)
    end
  end

  def place_ship(length)
    puts "\n\nEnter the squares for the #{length} unit ship:"
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
          puts "Not adjacent positions/ Not placed in a straight line"
        end
      else
        puts "Wrong number of cordinates!"
      end
      unless result
        puts "Please try placing your #{length} unit frigate again:"
      end
    end
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
    puts "Enter a coordinate to fire on:"
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
      puts "Not a valid position to fire at, try again:"
    end
    unless blank
      puts "You've already fired on that position,try again:"
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
      puts "You managed somehow to tie!"
    elsif @user_victory
      puts "You won the game, Congratulations hero!"
      puts "It took you #{@cpu_board.shots} shots to win!"
    else
      puts "You were defeated by my mighty fleet of warships!"
      puts "It took me #{@user_board.shots} shots to win!"
    end
    puts "The game took #{(Time.now - @start_time).round(2)} seconds to play."
    puts "Thankyou for playing Battleship"
  end



  def wrong_num_positions(number, wrong = true)
    if wrong
      puts "Wrong number of positions, please try again with #{number} positions:"
    end
    gets.chomp.split(" ")
  end

end

if __FILE__ == $0
  b = Battleship.new
end
