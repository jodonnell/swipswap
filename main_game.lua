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

  if self.control.startTouch then
     self.control.startTouch = nil
     self.tappedSquare = self.board:getTopOfColumn(self.control.x)
  end


  if self.control.endTouch and self.clickedOnSquare and self.clickedOnSquare.isMovingUp then
  elseif self.control.endTouch and self.clickedOnSquare then
    self:dropBlocks()
  elseif self.control.endTouch then
    self:pickupBlocks()
  end

  if self.clickedOnSquare then
     self.clickedOnSquare:update()
  end

  self.board:update()
end

function MainGame:dropBlocks()
  self.control.endTouch = nil

  self.clickedOnSquare:setGridX(self.control.x)
  self.clickedOnSquare.isFalling = true
  _.push(self.board:getColumn(self.control.x), self.clickedOnSquare)
  self.clickedOnSquare = nil
end

function MainGame:pickupBlocks()
  self.control.endTouch = nil

  _.pop(self.board:getColumn(self.tappedSquare:getGridX()))
  self.tappedSquare.isMovingUp = true
  self.clickedOnSquare = self.tappedSquare
end
