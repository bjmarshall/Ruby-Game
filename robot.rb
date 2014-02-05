require 'gosu'
require_relative 'world'
require_relative 'gamewindow'
require_relative 'Player'

class Robot < Player
    def initialize(window)
      @window = window
      @image = Gosu::Image.new(window, "resources/robot.png", false)
      @xdis = @ydis = @x = @y = 0
	  @vel_x = @vel_y = 0.0
      @score = 0
	  @w = @window.get_world
	  @gravity = 0.125
  end
end