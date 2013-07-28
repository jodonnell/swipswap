require 'class'
require 'global'
_ = require 'underscore'


Board = class()

function Board:init()
  self.tick = 0
  self.board = {}
  for x=1,self:rightOfBoard() do
    self.board[x] = {}
  end
  self:createNewRow()
end

function Board:isGameOver()
end

-- function Board:isSpotFilled(x, y)
--   return self.board[x][y] and self:getSquare(x, y).isDropping == false
-- end

function Board:getRow(x)
  return self.board[x]
end

-- function Board:setSquare(square)
--   self.board[square.gridX][square.gridY] = square
-- end

-- function Board:clearSquare(square)
--   self.board[square.gridX][square.gridY] = nil
-- end

function Board:rightOfBoard()
  return 9
end

-- function Board:bottomOfBoard()
--   return 13
-- end

-- function Board:anythingBelow(x, y)
--   return y == self:bottomOfBoard() or self:getSquare(x, y + 1)
-- end

function Board:update()
  -- self:findAndRemoveSquaresInARow()

  self.tick = self.tick + 1

  for i,square in ipairs(self:allSquares()) do
    square:update(self:shouldMoveSquareUp())
  end

  if self:shouldCreateNewRow() then
    self:createNewRow()
    self.tick = 0
  end
end

function Board:shouldMoveSquareUp()
  return self.tick % 4 == 0
end

function Board:shouldCreateNewRow()
  return self.tick == SQUARE_SIZE * 4
end

function Board:createNewRow()
  for x=1,self:rightOfBoard() do
    self:newSquareInRow(x)
  end
end

function Board:newSquareInRow(x)
  _.push(self.board[x], Square(x, SQUARE_START_Y, 'random', self))
end

function Board:allSquares()
  return _.flatten(self.board)
end

-- function Board:findAndRemoveSquaresInARow()
--   local squares = self:findSquaresInARow()
--   self:removeSquares(squares)
-- end

-- function Board:removeSquares(squares)
--   for i,square in ipairs(squares) do
--     square:startDisappearing()
--   end
-- end

-- function Board:findSquaresInARow()
--   local squares = {}
--   for y=1,self:bottomOfBoard() do
--     local squaresInARow = {}
--     for x=1,self:rightOfBoard() do
--       if self:isSpotFilled(x, y) then
--         squaresInARow = self:addOrRestartChain(self:getSquare(x, y), squaresInARow)
--       else 
--         squaresInARow = {}
--       end

--       if #squaresInARow > 2 then
--         squares = _.concat(squares, squaresInARow)
--       end
--     end
--   end
--   return squares
-- end

-- function Board:addOrRestartChain(square, squaresInARow)
--   if #squaresInARow > 0 and squaresInARow[1].color == square.color then
--     _.push(squaresInARow, square)
--   else
--     squaresInARow = {square}
--   end
--   return squaresInARow
-- end
