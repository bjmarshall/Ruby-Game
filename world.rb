require 'gosu'
require_relative 'gamewindow'
require_relative 'Block'

class World
  def initialize(window)
      @blocks = [Block.new(0, 256,window),Block.new(16, 256,window),Block.new(48, 256,window),Block.new(64, 256,window),Block.new(96, 256,window),Block.new(128, 256,window),Block.new(176, 256,window),Block.new(176, 240,window),Block.new(192, 256,window),Block.new(208, 256,window),Block.new(224, 240,window),Block.new(256, 256,window),Block.new(288, 256,window)]
      x = 224
	  while x < 608
	    @blocks.push(Block.new(x,256,window))
		x += 16
	  end
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