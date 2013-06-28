require 'class'

Board = class()

function Board:init()
	 self.board = {}
	 for i=1,9 do
      self.board[i] = {}
      for j=1,12 do
				 self.board[i][j] = false
      end
	 end
end

function Board:nextBelow(square)
	 local x = square.gridX
	 for y=1,12 do
			if self.board[x][y] ~= 0 then
				 self.board[x][y - 1] = square
				 return y - 1
			end
	 end
end

function Board:isGameOver()
end

function Board:isSpotFilled(x, y)
	 return self.board[x][y] ~= 0
end

function Board:getSquare(x, y)
	 return self.board[x][y]
end

function Board:setSquare(square)
	 self.board[square.gridX][square.gridY] = square
end

function Board:bottomOfGrid()
   return 12
end

function Board:anythingBelow(x, y)
   return y == self:bottomOfGrid() or self:getSquare(x, y + 1)
end