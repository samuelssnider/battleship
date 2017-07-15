require './lib/auto_setup'
require './lib/ship'
require 'pry'

class GameBoard
  attr_reader :board,
              :a,
              :b,
              :c,
              :d,
              :length,
              :ships
  def initialize(automated = false)
    @a = Array.new(4, " ")
    @b = Array.new(4, " ")
    @c = Array.new(4, " ")
    @d = Array.new(4, " ")
    @board = [@a, @b, @c, @d]
    @length = 4
    @map_letters = ["A", "B", "C", "D"]
    @ships = [Ship.new(2)]#, Ship.new(3)]
    if automated
      automated_setup
    end
  end


  def print_board
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
    computer = AutoSetup.new(@board, @ships)
    @board = computer.board
  end

  def place(placement_attempt)
    result = true
    if placement_attempt[0].nil? || placement_attempt[1].nil?
      result = false
    end
    placement_attempt.each do |p_att|
      @ships.each do |ship|
        ship.position.each do |pos|
          if p_att == pos
            result = false
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




end
