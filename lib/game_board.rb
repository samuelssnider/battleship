require './lib/auto_setup'
require './lib/ship'
require './lib/position'
require 'pry'

class GameBoard
  attr_reader :board,
              :a,
              :b,
              :c,
              :d,
              :length,
              :shots,
              :ships
  def initialize(difficulty, automated = false)
    @shots = 0
    @map_letters = ["A", "B", "C", "D"]
    @ships = []
    @a = []
    @b = []
    @c = []
    @d = []
    @board = []
    @length
    diff_setup(difficulty)
    init_board
    @automated = automated
    if automated
      automated_setup
    end
  end

  def diff_setup(difficulty)
    # beginner = false
    # intermediate = false
    # expert = false
    @ship_lengths = difficulty{:ship_lengths}
    @length = 
    # case difficulty{:diff}
    # when "Beginner"
    #   beginner = true
    #   @length = :length
    # when "Intermediate"
    #   intermediate = true
    #   @length = :length
    # when "Expert"
    #   expert = true
    #   @length = length
    # end
    @a = Array.new(@length, " ")
    @b = Array.new(@length, " ")
    @c = Array.new(@length, " ")
    @d = Array.new(@length, " ")
  end

  def init_board
    @board = [@a, @b, @c, @d]
  end


  def print_board
    init_board
    if @automated
      puts "Computer Board"
    else
      puts "Your Board"
    end
    puts "==========="
    puts ". 1 2 3 4"
    @board.each_with_index do |row, index|
      print @map_letters[index]
      row.each do |tile|
        print " #{tile}"
      end
      print "\n"
    end
    puts "===========".chomp
  end

  def automated_setup
    @ship_lengths.each do |length|
      @ships << Ship.new(length)
    end
    computer = AutoSetup.new(@board, @ships, @length)
    @board = computer.board
  end

  def place(placement_attempt)
    result = true
    if placement_attempt[0].nil? || placement_attempt[1].nil?
      result = false
    end
    if @ships.nil?
      result = true
    else
      placement_attempt.each do |p_att|
        @ships.each do |ship|
          ship.position.each do |pos|
            if p_att.placement == pos.placement
              result = false
              puts "There is already a ship there!"
            end
          end
        end
      end
    end
    if result
      ship = Ship.new(placement_attempt.length)
      ship.position = placement_attempt
      @ships << ship
    end
    result
  end

  def fire!(cordinates)
    save = nil
    hit = false
    @ships.each do |ship|
      ship.position.each do |pos|
        if pos.placement == cordinates.placement
          save = ship
          hit = true
        end
      end
    end
    if hit
      @board[cordinates.placement[0]][cordinates.placement[1]] = "H"
      save.hit
      if save.sunk && !@automated
        puts "They sunk your #{save.length} unit ship!"
      end
      if save.sunk && @automated
        puts "You sunk their #{save.length} unit ship!"
      end
    else
      @board[cordinates.placement[0]][cordinates.placement[1]] = "M"
    end
    @shots += 1
  end




end
