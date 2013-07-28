require 'class'
require 'global'
_ = require 'underscore'


Board = class()

function Board:init()
  self.offset = 0
  self.board = {}
  for x=1,self:rightOfBoard() do
    self.board[x] = {}
    for y=1,self:bottomOfBoard() do
      if y == self:bottomOfBoard() then
        self.board[x][y] = Square(x, y, 'random', self)
      else
        self.board[x][y] = false
      end
    end
  end
end

function Board:isGameOver()
end

function Board:isSpotFilled(x, y)
  return self.board[x][y] and self:getSquare(x, y).isDropping == false
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

function Board:rightOfBoard()
  return 9
end

function Board:bottomOfBoard()
  return 13
end

function Board:anythingBelow(x, y)
  return y == self:bottomOfBoard() or self:getSquare(x, y + 1)
end

function Board:update()
  self:findAndRemoveSquaresInARow()

  self.offset = self.offset + 1

  for i,square in ipairs(self:allSquares()) do
    square:update()

    if self.offset % 4 == 0 then
      square.square.y = square.square.y - 1
    end
  end

  if self.offset == SQUARE_SIZE * 4 then
    self:moveAllSquaresUp()
    self.offset = 0
  end
end


function Board:moveAllSquaresUp()
  for x=1,self:rightOfBoard() do
    for y=1,self:bottomOfBoard() do
      if self:isSpotFilled(x, y) then
        local square = self:getSquare(x, y)
        square:moveToY(square.gridY - 1)
      end

      if y == self:bottomOfBoard() then
        self.board[x][y] = Square(x, y, 'random', self)
      end
    end
  end
end

function Board:findAndRemoveSquaresInARow()
  local squares = self:findSquaresInARow()
  self:removeSquares(squares)
end

function Board:removeSquares(squares)
  for i,square in ipairs(squares) do
    square:startDisappearing()
  end
end

function Board:allSquares()
  local squares = {}
  for x=1,self:rightOfBoard() do
    for y=1,self:bottomOfBoard() do
      _.push(squares, self:getSquare(x, y))
    end
  end
  return _.compact(squares)
end

function Board:findSquaresInARow()
  local squares = {}
  for y=1,self:bottomOfBoard() do
    local squaresInARow = {}
    for x=1,self:rightOfBoard() do
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
