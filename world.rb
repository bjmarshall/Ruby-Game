require_relative 'block'

class World
  def initialize
      @blocks = [Block.new(0, 256),Block.new(16, 256),Block.new(48, 256),Block.new(64, 256),Block.new(96, 256),Block.new(128, 256),Block.new(176, 256),Block.new(176, 240),Block.new(192, 256),Block.new(208, 256),Block.new(224, 240)]
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