require 'pry'
require './lib/ship'
class AutoSetup
  attr_reader :board
  def initialize(board, ships)
    @board_ary = get_every_tile_array(board)
    @length = @board_ary.length
    placement_each(ships)
  end

  def get_every_tile_array(board)
    every_avail_tile = []
    board.each_with_index do |row, index|
      row.each_with_index do |tile,inner_index|
        every_avail_tile << [index, inner_index]
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
    first_position = @board_ary.sample
    if ship.length == 1
      ship_position = first_position
      binding.pry
      every_avail_tile.remove()
    end
    oth_pos_ary = build_continuation_arrray(first_position, ship.length)
    second_position = oth_pos_ary.sample
    if ship.length == 2
      ship.position = [first_position, second_position]
    end
  end


  def build_continuation_arrray(first_position, ship_length)
    continuation_array = []
    rp = first_position[0]    #row position
    cp = first_position[1]    #column position
    case ship_length
    when 1
      ship.position = first_position
    when 2
      if rp == 0
        if cp == 0
          continuation_array << [rp, (cp + 1)]
          continuation_array << [(rp + 1), cp]
        elsif cp == (@length - 1)
          continuation_array << [(rp + 1), cp]
          continuation_array << [rp, (cp - 1)]
        else
          continuation_array << [rp, (cp + 1)]
          continuation_array << [(rp - 1), cp]
          continuation_array << [(rp + 1), cp]
        end
      elsif rp == (@length - 1)
        if cp == 0
          continuation_array << [rp, (cp + 1)]
          continuation_array << [(rp - 1), cp]
        elsif cp == (@length - 1)
          continuation_array << [(rp - 1), cp]
          continuation_array << [rp, (cp - 1)]
        else
          continuation_array << [rp, (cp + 1)]
          continuation_array << [(rp - 1), cp]
          continuation_array << [(rp + 1), cp]
        end
      else
        if cp == 0
          continuation_array << [rp, (cp + 1)]
          continuation_array << [(rp - 1), cp]
          continuation_array << [(rp + 1), cp]
        elsif cp == (@length - 1)
          continuation_array << [rp, (cp - 1)]
          continuation_array << [(rp - 1), cp]
          continuation_array << [(rp + 1), cp]
        else
          continuation_array << [rp, (cp + 1)]
          continuation_array << [rp, (cp - 1)]
          continuation_array << [(rp - 1), cp]
          continuation_array << [(rp + 1), cp]
        end
      end
    else
    "position not found"
    end
    continuation_array
  end

end
