require 'gosu'


class Block
  def initialize(x,y,window,type)
	  @image = Gosu::Image.new(window, "resources/labBlock.png")
	  @x = x
	  @y = y
		case type
		when "l"
			@image = Gosu::Image.new(window, "resources/labBlock.png")
		when "r"
			@image = Gosu::Image.new(window, "resources/redBlock.png")
		when "b"
			@image = Gosu::Image.new(window, "resources/blueBlock.png")	
		when "B"
			@image = Gosu::Image.new(window, "resources/buildingBlock.png")
		when "a"
			@image = Gosu::Image.new(window, "resources/asphaltBlock.png")	
		when "c"
			@image = Gosu::Image.new(window, "resources/closedWindowBlock.png")
		when "q"
			@image = Gosu::Image.new(window, "resources/crackedBuildingBlock.png")
		when "w"
			@image = Gosu::Image.new(window, "resources/crackedBuildingBlock_2.png")
		when "d"
			@image = Gosu::Image.new(window, "resources/dirtBlock.png")
		when "g"
			@image = Gosu::Image.new(window, "resources/grassBlock.png")
		when "o"
			@image = Gosu::Image.new(window, "resources/openWindowBlock.png")
		when "h"
			@image = Gosu::Image.new(window, "resources/hoverBlock.png")	
		end
  end	  
  def get_x
    return @x
  end
  def get_y
	return @y
  end
  def get_image
    return @image
  end  
end