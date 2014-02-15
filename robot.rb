require 'gosu'
require_relative 'gamewindow'
require_relative 'world'
require_relative 'block'
require_relative 'Player'

class Robot < Player
    def initialize(window,x,y,world)
		  @x = x
			@xdis = x
			@y = y
			@ydis = y
      @window = window
      @image = Gosu::Image.new(window, "resources/robot.png", false)
			@vel_x = @vel_y = 0.0
      @score = 0
			@w = world
			@gravity = 0.125
  end
end