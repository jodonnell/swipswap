require 'class'

Square = class()

function Square:init(x, y, color, dropToSide, board)
	 self.squareSize = display.contentWidth / 9

	 self.square = display.newRoundedRect(0, 0, self.squareSize, self.squareSize, 4)
	 self:setColor(color)

	 self.gridX = x
	 self.gridY = y

	 self.square.x = gridConversion:convert(x)
	 self.square.y = gridConversion:convert(y)
	 
	 self.dropToSide = dropToSide

	 self.board = board
end

function Square:moveTo(x, y)
	 local transitionToParams = {time=1000, x=x, y=y}
	 transition.to(self.square, transitionToParams)
end

function Square:drop()
	 self.isDropping = true

	 self.finishedDropping = function() self.isDropping = false end
	 local transitionToParams = {time=1000, onComplete=self.finishedDropping}
	 if self.dropToSide == 'down' then
			transitionToParams['y'] = gridConversion:convert(self.board:nextBelow(self))
	 elseif self.dropToSide == 'right' then
			transitionToParams['x'] = gridConversion:convert(self.board:nextRight(self))
	 elseif self.dropToSide == 'up' then
			transitionToParams['y'] = gridConversion:convert(self.board:nextAbove(self))
	 elseif self.dropToSide == 'left' then
			transitionToParams['x'] = gridConversion:convert(self.board:nextLeft(self))
	 end
	 transition.to(self.square, transitionToParams)
end

function Square:finishedDropping()
	 self.isDropping = false
end

function Square:setColor(color)
	 if color == 'green' then
			self.square:setFillColor(0, 255, 0)
	 elseif color == 'grey' then
			self.square:setFillColor(200, 200, 200)
	 elseif color == 'red' then
			self.square:setFillColor(255, 0, 0)
	 elseif color == 'random' then
			self.square:setFillColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	 end

end