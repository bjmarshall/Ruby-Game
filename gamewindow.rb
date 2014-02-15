require 'gosu'
require_relative 'World'
require_relative 'player'
require_relative 'robot'
require_relative 'block'

class GameWindow < Gosu::Window
  def initialize
    @height = 480
	  @width = 640
    super @width, @height, false
		self.caption = "Demannu"
		@background = Gosu::Image.new(self, 'resources/cityBackground.png', true)
		@w = World.new(self,gets.chomp)
		@player = @w.get_player
		@robot = @w.get_robot
		@controlling = @player
		@offx = 0
		@was_tab = false
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @controlling.move_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @controlling.move_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @controlling.jump
    end
		if button_down? Gosu::KbTab or button_down? Gosu::GpButton1 then
			if !@was_tab
				@controlling = @controlling == @player ? @robot : @player
			end
				@was_tab = true	  
			else
			@was_tab = false
		end
    @player.move
    @robot.move
		@offx = @controlling.get_x_dis - @controlling.get_x
  end
  
  def get_world
    return @w
  end
  
  def draw
    @player.draw
		@robot.draw
    @background.draw(@offx/4 - 640,0,0)
		for b in @w.get_blocks
			if b.instance_of?(Block)
				b.get_image.draw(b.get_x+@offx,b.get_y, 1)
			end	
		end
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
  
  def get_controlling
	return @controlling
  end
  
  def get_height
    @height
  end  
  def get_width
    @width
  end
  def get_robot
    return @robot
  end
  def get_player
		return @player
  end
end   

GameWindow.new.show
exit