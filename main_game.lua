require 'class'
require 'square'
require 'board'
require 'grid_conversion'

MainGame = class()
gridConversion = GridConversion()

function MainGame:init(control)
   self.control = control

   self.board = Board()
   self.lifted = false
end


function MainGame:update()
   if self.board:isGameOver() then return end

   if self.control.startTouch and self.lifted == false then
      self.control.startTouch = nil
      self.liftingSquare = self.board:getSquare(self.control.x, self.control.y)
   elseif self.control.startTouch and self.liftingSquare then
      self.control.startTouch = nil
   end

   if self.control.endTouch and self.liftingSquare and self.lifted == false then
      self.control.endTouch = nil
      if self.control.y < self.liftingSquare.gridY then
         self.liftingSquare:removeFromBoard()
         self.liftingSquare:goToTop()
      end
      self.lifted = true
   elseif self.control.endTouch and self.lifted == true then
      self.control.endTouch = nil
      self.lifted = false
      self.liftingSquare:addToBoardFromTop(self.control.x)
      self.liftingSquare = nil
   end


   if self.liftingSquare then
      self.liftingSquare:update()
   end

   self.board:update()
end
