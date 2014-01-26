require 'gosu'
require_relative 'world'
require_relative 'player'

class GameWindow < Gosu::Window
  def initialize
    super 480, 270, false
	self.caption = "A respectable title"
	@background = Gosu::Image.new(self, 'resources/background.png', true)
	@player = Player.new(self)
    @player.warp(0, 224)
	@w = World.new

  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.move_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.move_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.jump
    end
    @player.move  
  end
  
  def draw
    @player.draw
    @background.draw(0,0,0)
	for b in @w.get_blocks
	  Gosu::Image.new(self, "resources/plat.png", false).draw(b.get_x, b.get_y, 1)
	end
  end
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end  
end   



window = GameWindow.new
window.show