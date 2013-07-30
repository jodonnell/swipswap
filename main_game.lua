require 'class'
require 'square'
require 'board'

MainGame = class()

function MainGame:init(control)
  self.control = control

  self.board = Board()
end


function MainGame:update()
  if self.board:isGameOver() then return end

  if self.control.startTouch then
     self.control.startTouch = nil
     self.clickedOnSquare = self.control.x
  end


  if self.control.endTouch then
    self.control.endTouch = nil

    local column = self.board:getColumn(self.clickedOnSquare)
    local topSquare = _.pop(column)
    topSquare:setGridX(self.control.x)
    topSquare:setY(0)
    topSquare.isFalling = true
    _.push(self.board:getColumn(self.control.x), topSquare)
  end

  -- if self.clickedOnSquare then
  --    self.clickedOnSquare:update()
  -- end

  self.board:update()
end
