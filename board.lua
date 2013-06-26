require 'class'

Board = class()

function Board:init()
	 self.board = {}
	 for i=1,9 do
      self.board[i] = {}
      for j=1,12 do
				 self.board[i][j] = 0
      end
	 end

	 self.board[5][7] = 1
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

function Board:nextAbove(square)
	 local x = square.gridX
	 for y=12,1,-1 do
			if self.board[x][y] ~= 0 then
				 self.board[x][y + 1] = square
				 return y + 1
			end
	 end
end

function Board:nextRight(square)
	 local y = square.gridY
	 for x=1,9 do
			if self.board[x][y] ~= 0 then
				 self.board[x - 1][y] = square
				 return x - 1
			end
	 end
end

function Board:nextLeft(square)
	 local y = square.gridY
	 for x=9,1,-1 do
			if self.board[x][y] ~= 0 then
				 self.board[x + 1][y] = square
				 return x + 1
			end
	 end
end

function Board:isGameOver()
	 if self.board[1][7] ~= 0 then
			return true
	 elseif self.board[9][7] ~= 0 then
			return true
	 elseif self.board[5][12] ~= 0 then
			return true
	 elseif self.board[5][1] ~= 0 then
			return true
	 end
	 return false
end

function Board:isSpotFilled(x, y)
	 return self.board[x][y] ~= 0
end

function Board:getSquare(x, y)
	 return self.board[x][y]
end