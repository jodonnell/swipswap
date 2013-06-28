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
			self.gridY = gridConversion:pixelsToGrid(self.square.y)
	 end
	 if self.board:anythingBelow(self.gridX, self.gridY) then
			self.isDropping = false
			self.dropped = true
			self.square.y = gridConversion:gridToPixels(self.gridY)
			self.board:setSquare(self)
	 end
end

function Square:setColor(color)
	 if color == 'random' then
			local colors = {'green', 'yellow', 'red', 'blue', 'pink', 'cyan'}
			color = colors[math.random(1, #colors)]
	 end

	 if color == 'red' then
			self.square:setFillColor(255, 0, 0)
	 elseif color == 'yellow' then
			self.square:setFillColor(255, 255, 0)
	 elseif color == 'pink' then
			self.square:setFillColor(255, 0, 255)
	 elseif color == 'green' then
			self.square:setFillColor(0, 255, 0)
	 elseif color == 'cyan' then
			self.square:setFillColor(0, 255, 255)
	 elseif color == 'blue' then
			self.square:setFillColor(0, 0, 255)
	 end

end