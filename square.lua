require 'class'

Square = class()

function Square:init(x, y, color, board)
	 self.squareSize = display.contentWidth / 9

	 self.square = display.newRoundedRect(0, 0, self.squareSize, self.squareSize, 4)
	 self:setColor(color)

	 self.gridX = x
	 self.gridY = y

	 self.square.x = gridConversion:gridToPixels(x)
	 self.square.y = gridConversion:gridToPixels(y)
	 
	 self.board = board
	 self.isDropping = false
	 self.dropped = false
end

function Square:moveTo(x)
	 self.square.x = gridConversion:gridToPixels(x)
	 self.gridX = x
end

function Square:finishedDropping()
	 self.isDropping = false
end

function Square:drop()
	 self.isDropping = true
end

function Square:update()
	 if self.isDropping then
			self.square.y = self.square.y + 15
	 end
	 if self.square.y > display.contentHeight - self.squareSize / 2 then
			self.isDropping = false
			self.dropped = true
			self.square.y = display.contentHeight - self.squareSize / 2
			self.gridY = 13
			self.board:setSquare(self)
	 end
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