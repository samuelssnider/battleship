require './lib/game_board'
require './lib/position'

class Battleship
  def initialize
    welcome_msg
    computer_ship_placement
    computer_done_placing_msg
    user_setup
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
    @user_board = GameBoard.new
    puts "\n\nEnter the squares for the two-unit ship:"
  end

  def user_setup
    place_ship(2)
  end


  def place_ship(length)
    stopper = true
    placement_array = []
    result = false
    until result == true
      user_commands = gets.chomp.split(" ")
      if user_commands.count == length
        user_commands.each do |user_command|
          pos = Position.new(user_command, @user_board.length)
          if placement_array.empty?
            placement_array << pos.placement
          else placement_array.last.adjacent?(pos) && pos.valid
            placement_array << pos.placement
          end
        end
      result = @user_board.place(placement_array)
      end
      unless result
        puts "Please try placing your 2 unit frigate again:"
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
