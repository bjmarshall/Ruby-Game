require 'gosu'
require_relative 'gamewindow'
require_relative 'Block'
require_relative 'Player'
require_relative 'Robot'

class World
  def initialize(window,level)
	  load_y = -1
	  @blocks = []
		f = File.open("levels/"+level, "r")
		for line in f
			line_a = line.split(",")
			if load_y < 0
				@player = Player.new(window, (line[0].to_i.floor)* 16, (line[1].to_i.floor) * 16, self)
				@player.warp( (line[0].to_i.floor)* 16, (line[1].to_i.floor) * 16 )
				@robot = Robot.new(window, line[2].to_i * 16, line[3].to_i * 16, self)
				@robot.warp( (line[2].to_i.floor)* 16, (line[3].to_i.floor) * 16 )
			else
			  line_a.delete(line_a[-1])
				for w in line_a
					@blocks.push(Block.new((w[0...w.length-1]).to_i * 16, load_y * 16, window, w[-1]))
				end
			end
			load_y += 1
		end
	end
	def get_player
	  return @player
	end
	def get_robot
		return @robot
	end
  def get_blocks
    return @blocks
  end
  def block_at(x, y)
	x -= (x%16 - 16)
	y -= y%16
	for b in @blocks
	  if b.get_x == x && b.get_y == y
	    return b
	  end
	end
    return false
  end
end