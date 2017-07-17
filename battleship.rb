require './lib/game_board'
require './lib/position'
require './lib/auto_position'

class Battleship
  def initialize

    @user_victory = false
    @cpu_victory = false
    @board_tiles = build_board_tiles

  end

  def runner
    welcome_msg
    computer_ship_placement
    computer_done_placing_msg
    user_setup
    until @cpu_victory || @user_victory
      user_turn
      cpu_turn
      victory_check
    end
    puts "Thankyou for playing Battleship"
  end

  def victory_check
    if @user_victory && @cpu_victory
      puts "You managed somehow to tie!"
    elsif @user_victory
      puts "You won the game, Congratulations hero!"
           "It took you #{@cpu_board.shots} to win!"
    else
      puts "You were defeated by my mighty fleet of warships!"
           "It took me #{@user_board.shots} to win!"
    end
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
    user_command = gets.chomp
    puts case user_command
    when "p"
      computer_ship_placement
    when "i"
      #
    when "q"
      #
    else
      puts  "\nYou typed '#{user_command}', sorry, that is not a valid command."
      puts  "Please try (p) - play, (i) - instructions, (q) - quit."
    end
  end

  def computer_ship_placement
    @cpu_board = GameBoard.new(true)
  end

  def computer_done_placing_msg
    puts "I have laid out my ships on the grid."
    puts "You now need to layout your two ships."
    puts "The first is two units long and the"
    puts "second is three units long."
    puts "The grid has A1 at the top left and D4 at the bottom right."
  end

  def user_setup
    @user_board = GameBoard.new
    place_ship(2)
    place_ship(3)
  end

  def user_turn
    @cpu_board.print_board
    puts "Enter a coordinate to fire on:"
    made = false
    until made == true && unfired == true
      input = gets.chomp
      pos = Position.new(input, @cpu_board.length)
      made = pos.valid
      if (@cpu.board[pos.placement[0]][pos.placement[1]] == "H") ||  (@cpu.board[pos.placement[0]][pos.placement[1]] == "M")
        unfired = true
      end
      unless made
        puts "Not a valid position to fire at, try again:"
      end
      unless unfired
        puts "You've already fired on that position,try again:"
      end
    end
    auto_pos = AutoPosition.new(pos.placement)
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


  def place_ship(length)
    puts "\n\nEnter the squares for the #{length} unit ship:"
    stopper = true
    placement_array = []
    result = false
    until result == true
      user_commands = gets.chomp.split(" ")
      if user_commands.count == length
        @placement_array  = []
        user_commands.each do |user_command|
          position_checker(user_command)
        end
        if @placement_array.count == user_commands.count
          result = @user_board.place(@placement_array.map {|position| position})
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
      else
        if @placement_array.last.adjacent?(pos)
          if @placement_array.count >= 2
            if pos.straight?(@placement_array)
              @placement_array << pos
            end
          else
            @placement_array << pos
          end
        end
      end
    end

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
