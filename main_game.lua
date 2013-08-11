require 'class'
require 'square'
require 'board'

MainGame = class()

function MainGame:init(control)
  self.control = control

  self.board = Board()
  self.tappedSquare = nil
  self.clickedOnSquare = nil
end


function MainGame:update()
  if self.board:isGameOver() then return end

  self:touched()
  self:endTouched()

  if self.clickedOnSquare then
     self.clickedOnSquare:update()
  end

  self.board:update()
end

function MainGame:dropBlocks()
  self.clickedOnSquare:setGridX(self.control.x)
  self.clickedOnSquare.isFalling = true
  _.push(self.board:getColumn(self.control.x), self.clickedOnSquare)
  self.clickedOnSquare = nil
end

function MainGame:pickupBlocks()
  if self.tappedSquare == nil then
    return
  end

  -- get all squares above current square.
  -- move em up
  _.pop(self.board:getColumn(self.tappedSquare:getGridX()))
  self.tappedSquare.isMovingUp = true
  self.clickedOnSquare = self.tappedSquare
end

function MainGame:touched()
  if not self.control.startTouch then
    return
  end

  self.control.startTouch = nil
  self.tappedSquare = self.board:getBlockInColumnAtY(self.control.x, self.control.y)
end

function MainGame:endTouched()
  if not self.control.endTouch then
    return
  end

  if self.clickedOnSquare and self.clickedOnSquare.isMovingUp then
  elseif self.clickedOnSquare then
    self.control.endTouch = nil
    self:dropBlocks()
  else
    self.control.endTouch = nil
    self:pickupBlocks()
  end
end
