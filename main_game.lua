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

  -- if self.control.startTouch then
  --    self.control.startTouch = nil
  --    self.clickedOnSquare = self.board:getSquare(self.control.x, self.control.y)
  -- end


  -- if self.control.endTouch then
  --   self.control.endTouch = nil

  --   if self.clickedOnSquare then
  --     if self.control.y < self.clickedOnSquare.gridY then
  --       self.clickedOnSquare:removeFromBoard()
  --       self.clickedOnSquare:goToTop()
  --     end
  --   else 
  --    self.clickedOnSquare:addToBoardFromTop(self.control.x)
  --    self.clickedOnSquare = nil
  --   end
  -- end

  -- if self.clickedOnSquare then
  --    self.clickedOnSquare:update()
  -- end

  self.board:update()
end
