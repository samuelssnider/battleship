require './lib/game_board'

class Battleship
  def initialize
    welcome_msg
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

    puts "\n\nEnter the squares for the two-unit ship:"
    user_command = gets.chomp
  end

end

if __FILE__ == $0
  b = Battleship.new
end
