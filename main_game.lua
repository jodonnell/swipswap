require 'class'
require 'square'
require 'board'

MainGame = class()

function MainGame:init(control)
  self.control = control

  self.board = Board()
  self.tappedX = nil
  self.clickedOnSquare = nil
end


function MainGame:update()
  if self.board:isGameOver() then return end

  if self.control.startTouch then
     self.control.startTouch = nil
     self.tappedX = self.control.x
  end


  if self.control.endTouch and self.clickedOnSquare then
    self.control.endTouch = nil

    self.clickedOnSquare:setGridX(self.control.x)
    self.clickedOnSquare.isFalling = true
    _.push(self.board:getColumn(self.control.x), self.clickedOnSquare)
    self.clickedOnSquare = nil

  elseif self.control.endTouch then
    self.control.endTouch = nil

    local topSquare = self.board:getTopOfColumn(self.tappedX)
    _.pop(self.board:getColumn(self.tappedX))
    topSquare.isMovingUp = true
    self.clickedOnSquare = topSquare
    -- topSquare:setGridX(self.control.x)
    -- topSquare:setY(0)
    -- topSquare.isFalling = true
    -- _.push(self.board:getColumn(self.control.x), topSquare)
  end

  if self.clickedOnSquare then
     self.clickedOnSquare:update()
  end

  self.board:update()
end
