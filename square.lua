require 'class'

Square = class()

function Square:init(x, y, color, board)
  self.squareSize = display.contentWidth / 9

  self.square = display.newRoundedRect(0, 0, self.squareSize, self.squareSize, 4)
  self:setColor(color)

  self.gridX = x
  self.gridY = y

  self.square.x = gridConversion:gridToPixels(x)
  self.square.y = gridConversion:gridToPixels(y)
  
  self.board = board
  self.isDropping = false
  self.isFlashing = false
  self.dropped = false
  self.square:setStrokeColor(255, 255, 255)
  self.square.strokeWidth = 1
end

function Square:moveTo(x)
  self.square.x = gridConversion:gridToPixels(x)
  self.gridX = x
end

function Square:moveToY(y)
  self.board:clearSquare(self)
  self.gridY = y
  self.square.y = gridConversion:gridToPixels(y)
  self.board:setSquare(self)
end

function Square:finishedDropping()
  self.isDropping = false
end

function Square:removeFromBoard()
  self.board:clearSquare(self)
end

function Square:addToBoardFromTop(x)
  self.gridY = 1
  self:moveTo(x)
  self.board:setSquare(self)
end

function Square:goToTop()
  self.isMovingUp = true
end

function Square:update()
  if self:shouldDrop() then
    self:drop()
  end


  if self.isDropping then
    self:moveDown()
  end

  if self.isMovingUp then
    self:moveUp()
  end

  if self.isDropping and self:anythingBelow() then
    self:hitBottom()
  end
end

function Square:moveDown()
  self.board:clearSquare(self)
  self.square.y = self.square.y + 15
  self.gridY = gridConversion:pixelsToGrid(self.square.y)
  self.board:setSquare(self)
end

function Square:moveUp()
  self.square.y = self.square.y - 30
  if self.square.y <= 0 then
    self.isMovingUp = false
    self.square.y = 0
  end
end

function Square:hitBottom()
  self.isDropping = false
  self.dropped = true
  self.square.y = gridConversion:gridToPixels(self.gridY)
end

function Square:anythingBelow()
  return self.board:anythingBelow(self.gridX, self.gridY)
end

function Square:blink()
  if(self.square.alpha < 1) then
    transition.to( self.square, {time=140, alpha=1})
  else 
    transition.to( self.square, {time=140, alpha=0.1})
  end
end

function Square:startDisappearing()
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

function Square:shouldDrop()
  return self.isDropping == false and not self:anythingBelow()
end

function Square:drop()
  self.isDropping = true
end

function Square:setColor(color)
  if color == 'random' then
    --color = _.first(_.shuffle({'green', 'yellow', 'red', 'blue', 'pink', 'cyan'}))
    color = _.first(_.shuffle({'green', 'yellow', 'red'}))
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
