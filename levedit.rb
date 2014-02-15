require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480, false
    self.caption = "Level Editor"
		@background = Gosu::Image.new(self, 'resources/editgrid.png', true)
		@player = Gosu::Image.new(self, 'resources/CharRight.png', false)
		@robot = Gosu::Image.new(self, 'resources/robot.png', false)
		@cursor = Gosu::Image.new(self, 'resources/CharRight.png')
		@b_id = ""
		@offx = 0
		@offy = 0
		@robcoord = [0,0]
		@playercoord = [0,0]
		@blockcoords = []
		@placing = "player"
  end
	
  def update
  end

  def draw
	@background.draw(0,0,0)
	@player.draw(@playercoord[0]+@offx, @playercoord[1]+@offy, 1)
	@robot.draw(@robcoord[0]+@offx, @robcoord[1]+@offy, 1)
	for b in @blockcoords
	  b[2].draw(b[0]*16+@offx,b[1]*16+@offy,0)
	end
	@cursor.draw(self.mouse_x, self.mouse_y, 1)
  end
  def button_down(id)
    case id
		when Gosu::Kb1
		  @cursor = Gosu::Image.new(self, 'resources/CharRight.png')
			@placing = "player"
		when Gosu::Kb2
		  @cursor = Gosu::Image.new(self, 'resources/robot.png')
			@placing = "robot"
		when Gosu::Kb3
		  @cursor = Gosu::Image.new(self, 'resources/labBlock.png')
			@b_id = "l"
			@placing = "block"
		when Gosu::Kb4
		  @cursor = Gosu::Image.new(self, 'resources/redBlock.png')
			@b_id = "r"
			@placing = "block"				
		when Gosu::Kb5
		  @cursor = Gosu::Image.new(self, 'resources/blueBlock.png')
			@b_id = "b"
			@placing = "block"	
		when Gosu::Kb6
		  @cursor = Gosu::Image.new(self, 'resources/buildingBlock.png')
			@b_id = "B"
			@placing = "block"
		when Gosu::Kb7
		  @cursor = Gosu::Image.new(self, 'resources/asphaltBlock.png')
			@b_id = "a"
			@placing = "block"		
		when Gosu::Kb8
		  @cursor = Gosu::Image.new(self, 'resources/closedWindowBlock.png')
			@b_id = "c"
			@placing = "block"		
		when Gosu::Kb9
		  @cursor = Gosu::Image.new(self, 'resources/crackedBuildingBlock.png')
			@b_id = "q"
			@placing = "block"
		when Gosu::Kb0
		  @cursor = Gosu::Image.new(self, 'resources/crackedBuildingBlock_2.png')
			@b_id = "w"
			@placing = "block"
			
			when Gosu::MsLeft
      case @placing
			  when "player"
				  @playercoord = [self.mouse_x-self.mouse_x%16 - @offx , self.mouse_y-self.mouse_y%16 - @offy]
				when "robot"
				  @robcoord = [self.mouse_x-self.mouse_x%16 - @offx , self.mouse_y-self.mouse_y%16 - @offy]
				when "block"
				  if !(@blockcoords.include? [ ((self.mouse_x - @offx) / 16).floor , ((self.mouse_y - @offy) / 16).floor, @cursor, @b_id] )
				    @blockcoords.push( [ ((self.mouse_x - @offx) / 16).floor , ((self.mouse_y - @offy) / 16).floor , @cursor, @b_id ] )
					end	
			end
    when Gosu::MsRight
			for b in @blockcoords
				if b[0] == ((self.mouse_x - @offx) / 16).floor && b[1] == ((self.mouse_y - @offy) / 16).floor
					@blockcoords.delete(b)
				end
			end	
    when Gosu::KbLeft
		  @offx += 16
    when Gosu::KbRight
		  @offx -= 16			
    when Gosu::KbUp
		  @offy += 16
    when Gosu::KbDown
		  @offy -= 16
		when Gosu::KbTab
		  close
		  save(@playercoord, @robcoord, @blockcoords)
		end
  end
end

	def save(pcoord,rcoord,bcoords)
	  fname = gets.chomp
	  file = File.new(("levels/"+fname),"w")
		file.puts((pcoord[0]/16).to_s + "," + (pcoord[1]/16).to_s + "," + (rcoord[0]/16).to_s + "," + (rcoord[1]/16).to_s)
		max_y = max_y_coord(bcoords)
		for i in 0..max_y
		  line = ""
			for b in bcoords
			  if b[1] == i
				  line = (line + b[0].to_s + b[3] + ",")
				end	
			end
			file.puts(line)
		end
	end
	def max_y_coord(coords)
	  max = coords[0][1]
		for y in coords
	    if y[1] > max
			  max = y[1]
			end	
		end
	return max	
	end	
GameWindow.new.show
