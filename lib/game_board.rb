require './lib/auto_setup'
require './lib/ship'
require 'pry'

class GameBoard
  attr_reader :board,
              :a,
              :b,
              :c,
              :d
  def initialize(automated = false)
    @a = Array.new(4, " ")
    @b = Array.new(4, " ")
    @c = Array.new(4, " ")
    @d = Array.new(4, " ")
    @board = [@a, @b, @c, @d]
    @map_letters = ["A", "B", "C", "D"]
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
  computer = AutoSetup.new(@board)
  binding.pry
  end

end
