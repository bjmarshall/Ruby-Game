require 'gosu'
require_relative 'gamewindow'
require_relative 'world'
require_relative 'block'

class Player
  def initialize(window, x, y, world)
	  @x = x
	  @y = y
	  @window = window
	  @facing_right = true
    @image = Gosu::Image.new(@window, "resources/CharLeft.png", false)
    @xdis = x
	  @ydis =  y
	  @vel_x = @vel_y = 0.0
    @score = 0
	  @w = world
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
	  if @facing_right
		  @image = Gosu::Image.new(@window, "resources/CharLeft.png", false)
		end
    @vel_x -= 2
  end
  
  def move_right
	  if @facing_right
		      @image = Gosu::Image.new(@window, "resources/CharRight.png", false)
		end
    @vel_x +=2
  end
  
  def jump
    if is_falling? == false
	    @vel_y = -3.0
			@y -= 5
	  end  
  end
  
  def move
		if @window.get_world.block_at(@x+@vel_x+8,@y+@vel_y) == false && @window.get_world.block_at(@x+@vel_x+6,@y+16+@vel_y) == false && @window.get_world.block_at(@x+@vel_x-6,@y+@vel_y) == false && @window.get_world.block_at(@x-6+@vel_x,@y+16+@vel_y) == false
			@x += @vel_x
			if (!(@xdis >= @window.get_width/2 && @vel_x >= 0)) && (!(@xdis <= @window.get_width/3 && @vel_x <= 0)) && @window.get_controlling.instance_of?(self.class)
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
    if @window.get_controlling.instance_of? self.class
	    @image.draw(@xdis, @ydis, 1)
	  else
      @image.draw(@window.get_controlling.get_x_dis - (@window.get_controlling.get_x - @x), @ydis, 1)
	  end  
  end
  
  def is_falling?
		for i in (-1..1)
			if (@window.get_world.block_at(@x+(i*4),@y+36) != false)
				@y = @window.get_world.block_at(@x+(i*4),@y+36).get_y-32
				return false
			end
		end
    return true		
  end
end	