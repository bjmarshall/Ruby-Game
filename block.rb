require 'gosu'


class Block
  def initialize(x,y,window)
	  @x = x
	  @y = y
	  @image = Gosu::Image.new(window,"resources/plat.png", false)
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