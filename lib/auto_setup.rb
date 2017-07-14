require 'pry'
require './lib/ship'
class AutoSetup

  def initialize(board)
    @board_ary = get_every_tile_array(board)
    @length = @board_ary.length
    placement_each
  end

  def get_every_tile_array(board)
    every_tile = []
    board.each_with_index do |row, index|
      row.each_with_index do |tile,inner_index|
        every_tile << [index, inner_index]
      end
    end
    every_tile
  end

  def placement_each
    placement(Ship.new(2))
    placement(Ship.new(3))
  end

  def placement(ship)
    first_position = board_ary.sample
    oth_pos = build_continuation_arrray(first_position, ship.length)
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



  end

end
