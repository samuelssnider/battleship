require 'pry'
require './lib/ship'
require './lib/auto_position'
class AutoSetup
  attr_reader :board
  def initialize(board, ships, length)
    @board_rem_tiles = []
    @board = board
    get_every_tile_array
    @length = length
    placement_each(ships)
  end

  def get_every_tile_array
    @board.each_with_index do |row, index|
      row.each_with_index do |tile,inner_index|
        @board_rem_tiles << AutoPosition.new([index, inner_index])
      end
    end
  end

  def placement_each(ships)
    ships.each do |ship|
      placement(ship)
    end
  end

  def placement(ship)
    ship_positions = []
    first_position = @board_rem_tiles.sample
    @board_rem_tiles.delete(first_position)
    ship_positions << first_position
    ship_positions = build_continuation(ship_positions)
    (ship.length - 2).times do
      ship_positions = build_continuation(ship_positions, true)
    end
    ship.position = ship_positions
  end


  def build_continuation(positions, keep_straight = false)
    unless keep_straight
      additions = @board_rem_tiles.find_all do |tile|
        tile.adjacent?(positions[0])
      end
    else
      additions = @board_rem_tiles.find_all do |tile|
        tile.straight?(positions)
      end
    end
    save = additions.sample
    @board_rem_tiles.delete(save)
    positions << save
    positions
  end

end
