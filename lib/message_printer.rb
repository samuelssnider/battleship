class MessagePrinter
  def welcome_message
    puts "Welcome to BATTLESHIP \n \n"
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def instructions
    puts "This is a computer version of the tabletop game BATTLESHIP."
    puts "The player begins by placing his/her ships on the board."
    puts "After setup, you and the computer take turns firing at each other"
    puts "until all ships on either side have been sunk. The first player to"
    puts "sink the others' entire fleet wins the game!"
  end

  def play_instr_quit_err_msg(user_command)
    puts  "\nYou typed '#{user_command}', sorry, that is not a valid command."
    puts  "Please try (p) - play, (i) - instructions, (q) - quit."
  end

  def modes_msg
    puts  "Please enter difficulty (b) - beginner, (i) - intermediate, (e) - expert"
  end

  def modes_input_err(user_command)
    puts  "\nYou typed '#{user_command}', sorry, that is not a valid command."
    puts  "Please try (b) - begginer, (i) - intermediate, (e) - expert."
  end

  def cpu_setup_complete_msg(bot_corner)
    puts "I have laid out my ships on the grid."
    puts "You now need to layout your two ships."
    puts "The first is two units long and the"
    puts "second is three units long."
    puts "The grid has A1 at the top left and #{bot_corner} at the bottom right."
  end

  def straight_adjacent_error_msg
    puts "Not adjacent positions/ Not placed in a straight line"
  end

  def wrong_num_cordinates
    puts "Wrong number of cordinates!"
  end

  def try_placing_again(length)
    puts "Please try placing your #{length} unit frigate again:"
  end

  def fire_cordinates_request
    puts "Enter a coordinate to fire on:"
  end

  def enter_ship_placement_cordinates(length)
    puts "\n\nEnter the cordinates for the #{length} unit ship:"
  end

  def invalid_firing_position
    puts "Not a valid position to fire at, try again:"
  end

  def already_fired_at
    puts "You've already fired on that position,try again:"
  end

  def tie_game(shots)
    puts "You managed somehow to tie!"
    puts "You both fired #{shots} shots"
  end

  def user_victory(shots)
    puts "You won the game, Congratulations hero!"
    puts "It took you #{shots} shots to win!"
  end

  def cpu_victory(shots)
    puts "You were defeated by my mighty fleet of warships!"
    puts "It took me #{shots} shots to win!"
  end

  def time_and_thankyou(time)
    puts "The game took #{time} seconds to play."
    puts "Thankyou for playing Battleship"
  end

  def wrong_number_of_input_positions
    puts "Wrong number of positions, please try again with #{number} positions:"
  end


end
