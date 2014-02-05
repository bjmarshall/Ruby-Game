require 'gosu'
require_relative 'gamewindow'
require_relative 'World'
require_relative 'Block'

class Player
  def initialize(window)
	@window = window
    @image = Gosu::Image.new(@window, "resources/CharLeft.png", false)
    @xdis = @ydis = @x = @y = 0
	@vel_x = @vel_y = 0.0
    @score = 0
	@w = window.get_world
	@gravity = 0.125
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def get_x
    return @x
  end
  
  def get_y_dis
    return @ydis
  end
  
  def get_x_dis
    return @xdis
  end
  
  def get_y
    return @y
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
	  if (!(@xdis >= @window.get_width/2 && @vel_x >= 0)) && (!(@xdis <= @window.get_width/3 && @vel_x <= 0)) && @window.get_controlling.instance_of?(Player)
	    @xdis += @vel_x
	  end
	end  
	if is_falling? || @vel_y < 0
	  @y += @vel_y
    end
    	
    if @vel_y < 6.0
	  @vel_y += @gravity
	end  
	@ydis = @y
	draw
    @vel_x = 0
  end

  def draw
    @image.draw(@xdis, @ydis, 1)
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