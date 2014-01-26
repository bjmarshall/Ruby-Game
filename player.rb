require 'gosu'
require_relative 'world'

class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "resources/CharLeft.png", false)
    @x = @y = @vel_x =0.0
		@vel_y = 0.6
    @score = 0
		@w = World.new
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def move_left
    @x -= 2
  end
  
  def move_right
    @x +=2
  end
  
  def jump
    if is_falling? == false
	    @vel_y = -3.0
			@y -= 5
	  end  
  end
  
  def move
    @xmod = @vel_x > 0 ? 17: 0
			@x += @vel_x
		if is_falling? || @vel_y < 0
			@y += @vel_y*2
    end
    @x %= 640
    @y %= 480
    
		
	  if @vel_y >= -0.1 && @vel_y <= 0.0 && is_falling?
	    @vel_y *= -1
		end
		@vel_y *= @vel_y <= 0.0 ? 0.9 : @vel_y < 3.0 ? 1/0.9 : 1
  end

  def draw
    @image.draw(@x, @y, 1)
  end
  
  def is_falling?
	  for i in (-1..1)
			if @w.block_at(@x+(i*8),@y+36) != false
				@y = @w.block_at(@x+(i*8),@y+36).get_y-32
				return false
			end
		end	
    return true		
  end
	
end	