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

function Board:nextBelow(x)
	 for y=1,12 do
			if self.board[x][y] == 1 then
				 self.board[x][y - 1] = 1
				 return y - 1
			end
	 end
end

function Board:nextAbove(x)
	 for y=12,1,-1 do
			if self.board[x][y] == 1 then
				 self.board[x][y + 1] = 1
				 return y + 1
			end
	 end
end

function Board:nextRight(y)
	 for x=1,9 do
			if self.board[x][y] == 1 then
				 self.board[x - 1][y] = 1
				 return x - 1
			end
	 end
end

function Board:nextLeft(y)
	 for x=9,1,-1 do
			if self.board[x][y] == 1 then
				 self.board[x + 1][y] = 1
				 return x + 1
			end
	 end
end

function Board:isGameOver()
	 if self.board[1][7] == 1 then
			return true
	 elseif self.board[9][7] == 1 then
			return true
	 elseif self.board[5][13] == 1 then
			return true
	 elseif self.board[5][1] == 1 then
			return true
	 end
	 return false
end