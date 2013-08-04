require 'class'
require 'global'

Square = class()

function Square:init(x, y, color, board)
  self.square = display.newRoundedRect(0, 0, SQUARE_SIZE, SQUARE_SIZE, 4)
  self:setColor(color)
  self.square:setStrokeColor(255, 255, 255)
  self.square.strokeWidth = 1


  self:setGridX(x)
  self.square.y = y
  
  self.board = board
  self.isFalling = false
  self.isMovingUp = false
  -- self.isDropping = false
  -- self.isFlashing = false
  -- self.dropped = false
end

function Square:setGridX(x)
  self.gridX = x
  self.square.x = gridToPixels(x)
end

function Square:setY(y)
  self.square.y = y
end

function Square:x()
  return self.square.x
end

function Square:y()
  return self.square.y
end

function Square:update(moveUp)
  if self:shouldMoveUp(moveUp) then
    self.square.y = self.square.y - 1
  end

  if self.isFalling then
    self:fall()
  end

  if self.isMovingUp then
    self:moveUp()
  end
end

function Square:shouldMoveUp(moveUp)
  return moveUp and not self.isFalling and not self.isMovingUp
end

function Square:fall()
  self.square.y = self.square.y + 10
end

function Square:moveUp()
  self.square.y = self.square.y - 10
  if self:y() < SQUARE_SIZE / 2 then
    self.square.y = SQUARE_SIZE / 2
    self.isMovingUp = false
  end
end

function Square:setColor(color)
  if color == 'random' then
    color = _.first(_.shuffle({'green', 'yellow', 'red', 'blue', 'pink', 'cyan'}))
    --color = _.first(_.shuffle({'green', 'yellow', 'red'}))
  end

  self.color = color
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

function Square:blink()
  if(self.square.alpha < 1) then
    transition.to( self.square, {time=140, alpha=1})
  else 
    transition.to( self.square, {time=140, alpha=0.1})
  end
end

function Square:startDisappearing()
  if self.isFlashing then
    return
  end

  self.isFlashing = true

  transition.to( self.square, {time=140, alpha=0.1})
  self.blinkingTimer = timer.performWithDelay( 150, function() self:blink() end, 0 )
  timer.performWithDelay( 2000, function() self:endDisappearing() end )
end

function Square:endDisappearing()
  timer.cancel(self.blinkingTimer)
  self.square:removeSelf()
  self.board:clearSquare(self)
end
