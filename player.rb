require 'gosu'
require_relative 'world'

class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "resources/CharLeft.png", false)
    @x = @y = @vel_x =0.0
	@vel_y = 0.6
    @score = 0
	@w = World.new
	@gravity = 0.125
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def move_left
    @vel_x -= 2
  end
  
  def move_right
    @vel_x +=2
  end
  
  def jump
    if is_falling? == false
	    @vel_y = -3.0
			@y -= 5
	  end  
  end
  
  def move    
	if @w.block_at(@x+@vel_x+4,@y) == false && @w.block_at(@x+@vel_x+4,@y+16) == false && @w.block_at(@x+@vel_x-6,@y) == false && @w.block_at(@x-6+@vel_x,@y+16) == false
	  @x += @vel_x
	end  
	@vel_x = 0
	if is_falling? || @vel_y < 0
	  @y += @vel_y
    end
	
    @x %= 640
    @y %= 480
    	
    if @vel_y < 6.0
	  @vel_y += @gravity
	end  
  end

  def draw
    @image.draw(@x, @y, 1)
  end
  
  def is_falling?
	for i in (-1..1)
	  if @w.block_at(@x+(i*4),@y+36) != false
		@y = @w.block_at(@x+(i*4),@y+36).get_y-32
	    return false
	  end
	end	
    return true		
  end
	
end	