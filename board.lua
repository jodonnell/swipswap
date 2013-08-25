require 'class'
require 'global'
require 'row_finder'
require 'column_finder'
require 'square'
require 'block'
require 'ghost'
require 'column'
_ = require 'underscore'


Board = class()

function Board:init()
  self.tick = 0
  self.board = {}

  self.finders = {RowFinder(self), ColumnFinder(self)}

  for x=1,self:rightOfBoard() do
    self.board[x] = Column({})
  end
  self:createNewRow()
end

function Board:isGameOver()
end

function Board:getColumn(x)
  return self.board[x]
end

function Board:clearSquare(block)
  local column = self:getColumn(block.gridX)
  column:removeBlock(block)
end

function Board:rightOfBoard()
  return 9
end

function Board:bottomOfBoard()
  return 13
end

function Board:update()
  self:findAndRemoveSquares()
  self:makeAnyGhostsRush()

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

function Board:eachColumn(func)
  for x=1,self:rightOfBoard() do
    func(self:getColumn(x))
  end
end

function Board:checkForSquaresToBeginFalling()
  self:eachColumn(function (column)
    column:checkForSquaresToBeginFalling(self:bottomOffset())
  end)
end

function Board:checkForSquaresToEndFalling()
  self:eachColumn(function (column)
    column:checkForSquaresToEndFalling()
    self:checkForSquareHittingBottom(column)
  end)
end

function Board:checkForSquareHittingBottom(column)
  if not column:isEmpty() then
    local block = column:getBottom()
    if block.isFalling and block:y() > self:bottomOffset() then
      block.isFalling = false
      block:setY(self:bottomOffset())
    end
  end
end

function Board:bottomOffset()
  return SQUARE_START_Y - (SQUARE_SIZE / 2) - math.floor(self.tick / 12)
end

function Board:shouldMoveSquareUp()
  return self.tick % GAME_SPEED == 0
end

function Board:shouldCreateNewRow()
  return self.tick == SQUARE_SIZE * GAME_SPEED
end

function Board:createNewRow()
  for x=1,self:rightOfBoard() do
    self:newSquareInColumn(x, self:randomBlock(x))
  end
end

function Board:newSquareInColumn(x, block)
  self:getColumn(x):addBlock(block)
end

function Board:allSquares()
  local blocks = {}
  for x=1,self:rightOfBoard() do
    _.push(blocks, self:getColumn(x).blocks)
  end

  return _.flatten(blocks)
end

function Board:removeSquares(squares)
  _.invokeObj(squares, "startDisappearing")
end

function Board:findAndRemoveSquares()
  _.each(self.finders, function(finder)
    self:removeSquares(finder:find())
  end)
end

function Board:randomBlock(x)
  local number = math.random(1, 100)
  if number > 90 then
    return Block(x, SQUARE_START_Y, Ghost('random'), self)
  else
    return Block(x, SQUARE_START_Y, Square('random'), self)
  end
end

function Board:makeAnyGhostsRush()
  self:eachColumn(function(column)
    if not column:isEmpty() then
      local top = column:getTop()
      top:uncovered()
    end
  end)
end

function Board:getBlockInColumnAtY(column, y)
  local foundBlock = nil
  self:getColumn(column):each(function(block)
    if block:isYInBlock(y) then
      foundBlock = block
    end
  end)
  return foundBlock
end

function Board:getAllAbove(block)
  local column = self:getColumn(block:getGridX())
  return column:getAllAbove(block) 
end
