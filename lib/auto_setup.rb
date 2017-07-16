require 'pry'
require './lib/ship'
require './lib/auto_position'
class AutoSetup
  attr_reader :board
  def initialize(board, ships, length)
    @board_rem_tiles
    get_every_tile_array(board)
    @length = length
    placement_each(ships)
  end

  def get_every_tile_array(board)
    board.each_with_index do |row, index|
      row.each_with_index do |tile,inner_index|
        @board_rem_tiles << AutoPosition.new([index, inner_index])
      end
    end
    every_avail_tile
  end

  def placement_each(ships)
    ships.each do |ship|
      placement(ship)
    end
  end

  def placement(ship)
    ship_positions = []
    first_position = @board_rem_tiles.sample
    @board_rem_tiles.remove(first_position)
    ship_positions << first_position
    ship positions = build_continuation(ship_positions)
    (ship.length - 2).times do
      ship_positions = build_continuation(ship_positions, true)
    end
  end


  def build_continuation(positions, keep_straight = false)
    unless keep_straight
      additions = @board_remaining_tiles.find_all do |tile|
        tile.adjacent?(positions[0])
      end
    else
      additions = @board_remaining_tiles.find_all do |tile|
        tile.straight?(place_set)
      end
    end
    save = additions.sample
    @board_rem_tiles.remove(save)
    positions << save
    positions
  end

end
