require 'class'
require 'global'
require 'row_finder'
require 'column_finder'
_ = require 'underscore'


Board = class()

function Board:init()
  self.tick = 0
  self.board = {}

  self.finders = {RowFinder(self), ColumnFinder(self)}

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

function Board:getColumn(x)
  return self.board[x]
end

function Board:getTopOfColumn(x)
  return self.board[x][#self.board[x]]
end

-- function Board:setSquare(square)
--   self.board[square.gridX][square.gridY] = square
-- end

function Board:clearSquare(squareToRemove)
  self.board[squareToRemove.gridX] = _.reject(self.board[squareToRemove.gridX], function(square) 
    return square == squareToRemove 
  end)
end

function Board:rightOfBoard()
  return 9
end

function Board:bottomOfBoard()
  return 13
end

-- function Board:anythingBelow(x, y)
--   return y == self:bottomOfBoard() or self:getSquare(x, y + 1)
-- end

function Board:update()
  self:findAndRemoveSquares()

  self.tick = self.tick + 1

  _.each(self:allSquares(), function(square)
    square:update(self:shouldMoveSquareUp())
  end)

  self:checkForSquaresToBeginFalling()
  self:checkForSquaresToEndFalling()

  if self:shouldCreateNewRow() then
    self:createNewRow()
    self.tick = 0
  end
end

function Board:checkForSquaresToBeginFalling()
  for x=1,self:rightOfBoard() do
    if #self.board[x] > 1 then
      for y=2, #self.board[x] do
        if math.abs(self.board[x][y]:y() - self.board[x][y - 1]:y()) > SQUARE_SIZE then
          self.board[x][y].isFalling = true
        end
      end
    end
  end
end

function Board:checkForSquaresToEndFalling()
  for x=1,self:rightOfBoard() do
    if #self.board[x] > 1 then
      for y=2, #self.board[x] do
        if math.abs(self.board[x][y]:y() - self.board[x][y - 1]:y()) < SQUARE_SIZE then
          self.board[x][y].isFalling = false
          self.board[x][y]:setY(self.board[x][y - 1]:y() - SQUARE_SIZE)
        end
      end
    end
  end
end

function Board:shouldMoveSquareUp()
  return self.tick % GAME_SPEED == 0
end

function Board:shouldCreateNewRow()
  return self.tick == SQUARE_SIZE * GAME_SPEED
end

function Board:createNewRow()
  for x=1,self:rightOfBoard() do
    self:newSquareInRow(x)
  end
end

function Board:newSquareInRow(x)
  _.unshift(self.board[x], Square(x, SQUARE_START_Y, 'random', self))
end

function Board:allSquares()
  return _.flatten(self.board)
end

function Board:removeSquares(squares)
  _.invokeObj(squares, "startDisappearing")
end

function Board:findAndRemoveSquares()
  _.each(self.finders, function(finder)
    self:removeSquares(finder:find())
  end)
end
