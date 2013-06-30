require 'class'
_ = require 'underscore'


Board = class()

function Board:init()
	 self.board = {}
	 for x=1,9 do
      self.board[x] = {}
      for y=1,12 do
				 self.board[x][y] = false
      end
	 end
end

function Board:isGameOver()
end

function Board:isSpotFilled(x, y)
	 return self.board[x][y]
end

function Board:getSquare(x, y)
	 return self.board[x][y]
end

function Board:setSquare(square)
	 self.board[square.gridX][square.gridY] = square
end

function Board:clearSquare(square)
	 self.board[square.gridX][square.gridY] = nil
end

function Board:bottomOfGrid()
   return 12
end

function Board:anythingBelow(x, y)
   return y == self:bottomOfGrid() or self:getSquare(x, y + 1)
end

function Board:update()
   local squares = self:findSquaresInARow()
   
   for i,square in ipairs(squares) do
      if not square.isFlashing then
         square:startDisappearing()
      end
   end

   self:removeDeadSquares()

   for i,square in ipairs(self:allSquares()) do
      if square.isDropping == false and not square:anythingBelow() then
         square:drop()
      end
      square:update()
   end
end

function Board:removeDeadSquares()
   for x=1,9 do
      for y=1,12 do
         if self:isSpotFilled(x, y) then
            local square = self:getSquare(x, y)
            if square.disappear then
               square.square:removeSelf()
               self.board[x][y] = nil
            end
         end
      end
   end
end

function Board:allSquares()
   local squares = {}
   for x=1,9 do
      for y=1,12 do
         if self:isSpotFilled(x, y) then
            _.push(squares, self:getSquare(x, y))
         end
      end
   end
   return squares
end

function Board:findSquaresInARow()
   local squares = {}
   for y=1,12 do
      local squaresInARow = {}
      for x=1,9 do
				 if self:isSpotFilled(x, y) then
            squaresInARow = self:addOrRestartChain(self:getSquare(x, y), squaresInARow)
         else 
            squaresInARow = {}
         end

         if #squaresInARow > 2 then
            squares = _.concat(squares, squaresInARow)
         end
      end
	 end
   return squares
end

function Board:addOrRestartChain(square, squaresInARow)
   if #squaresInARow > 0 and squaresInARow[1].color == square.color then
      _.push(squaresInARow, square)
   else
      squaresInARow = {square}
   end
   return squaresInARow
end