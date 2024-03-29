require 'class'
require 'global'

Block = class()

function Block:init(x, y, sprite, board)
  self.sprite = sprite
  self.square = sprite.square
  self.color = sprite.color

  self:setGridX(x)
  self.square.y = y
  
  self.board = board
  self.isFalling = false
  self.isMovingUp = false
  self.isRushing = false
end

function Block:setGridX(x)
  self.gridX = x
  self.square.x = gridToPixels(x)
end

function Block:setY(y)
  self.square.y = y
end

function Block:x()
  return self.square.x
end

function Block:getGridX()
  return self.gridX
end

function Block:y()
  return self.square.y
end

function Block:update(moveUp)
  if self:shouldMoveUp(moveUp) then
    self.square.y = self.square.y - 1
  end

  if self.isFalling then
    self:fall()
  end

  if self.isRushing then
    self:moveUp(3)
  elseif self.isMovingUp then
    self:moveUp(10)
  end
end

function Block:hasReachedTop()
  return self.isRushing and self:y() <= 0
end

function Block:shouldMoveUp(moveUp)
  return moveUp and not self.isFalling and not self.isMovingUp
end

function Block:fall()
  self.square.y = self.square.y + 10
end

function Block:moveUp(speed)
  self.square.y = self.square.y - speed
end

function Block:blink()
  if(self.square.alpha < 1) then
    transition.to( self.square, {time=140, alpha=1})
  else 
    transition.to( self.square, {time=140, alpha=0.1})
  end
end

function Block:startDisappearing()
  if self.isFlashing then
    return
  end

  self.isFlashing = true

  transition.to( self.square, {time=140, alpha=0.1})
  self.blinkingTimer = timer.performWithDelay( 150, function() self:blink() end, 0 )
  timer.performWithDelay( 2000, function() self:endDisappearing() end )
end

function Block:endDisappearing()
  timer.cancel(self.blinkingTimer)
  self.square:removeSelf()
  self.board:clearSquare(self)
end

function Block:uncovered()
  self.sprite:uncovered(self)
end

function Block:isNormalState()
  return not (self.isFlashing or self.isFalling or self.isRushing)
end

function Block:isYInBlock(y)
  if y >= self:y() - SQUARE_SIZE / 2 and y <= self:y() + SQUARE_SIZE / 2 then
    return true
  end
  return false
end
