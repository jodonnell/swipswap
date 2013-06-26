require 'class'
require 'control'
require 'square'
require 'board'
require 'grid_conversion'

MainGame = class()
control = Control()
gridConversion = GridConversion()

function MainGame:init()
	 self.board = Board()

	 self.squareSize = display.contentWidth / 9
	 self.centerSquare = Square(5, 7, 'grey', 'down', self.board)

	 self.droppingSquare = Square(5, 1, 'green', 'down', self.board)
	 self.droppingSquare:drop()

	 self.squares = {}
	 self.movingSquare = nil
end


function MainGame:mainGameLoop()
   if self.board:isGameOver() then return end

	 if self.droppingSquare.isDropping == false then
			table.insert(self.squares, self.droppingSquare)
			local rand = math.random(1, 4)
			if rand == 1 then
				 self.droppingSquare = Square(1, 7, 'random',  'right', self.board)
			elseif rand == 2 then
				 self.droppingSquare = Square(9, 7, 'random',  'left', self.board)
			elseif rand == 3 then
				 self.droppingSquare = Square(5, 13, 'random',  'up', self.board)
			else
				 self.droppingSquare = Square(5, 1, 'random',  'down', self.board)
			end
			self.droppingSquare:drop()
	 end

	 if control.x and control.startTouch then
			local x = gridConversion:pixelsToGrid(control.x)
			local y = gridConversion:pixelsToGrid(control.y)
			self.movingSquare = self.board:getSquare(x, y)
			control.x = nil
			control.y = nil
			control.startTouch = nil
	 elseif control.x then
			local x = gridConversion:pixelsToGrid(control.x)
			local y = gridConversion:pixelsToGrid(control.y)
			self.movingSquare:moveTo(x, y)

			control.x = nil
			control.y = nil
			control.endTouch = nil
	 end


end


local function onScreenTouch( event )
  if event.phase == "began" then
		 control.x = event.x
		 control.y = event.y
		 control.startTouch = true
  elseif event.phase == "moved" then
		 
		 -- control.x = event.x
		 -- control.y = event.y
  elseif event.phase == "ended" or event.phase == "cancelled" then
		 control.x = event.x
		 control.y = event.y
		 control.endTouch = true
  end

  return true
end

Runtime:addEventListener( "touch", onScreenTouch )
