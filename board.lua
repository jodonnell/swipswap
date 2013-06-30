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

   self:flashSquares()
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
            table.insert(squares, self:getSquare(x, y))
         end
      end
   end
   return squares
end

function Board:flashSquares()
   for i,square in ipairs(self:allSquares()) do
      if square.isFlashing and square.square.isVisible then
         square.square.isVisible = false
      elseif square.isFlashing and square.square.isVisible == false then
         square.square.isVisible = true
      end
   end
end

function Board:findSquaresInARow()
   local squares = {}
   for y=1,12 do
      local squaresInARow = {}
      for x=1,9 do
				 if self:isSpotFilled(x, y) then
            local square = self:getSquare(x, y)
            if #squaresInARow > 0 then
               if squaresInARow[1].color == square.color then
                  table.insert(squaresInARow, square)
               else
                  squaresInARow = {square}
               end
            else
               table.insert(squaresInARow, square)
            end
         else 
            squaresInARow = {}
         end

         if #squaresInARow > 2 then
            for i,square in ipairs(squaresInARow) do
               table.insert(squares, square)
            end
         end
      end
	 end
   return squares
end