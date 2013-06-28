require 'class'
require 'square'
require 'board'
require 'grid_conversion'

MainGame = class()
gridConversion = GridConversion()

function MainGame:init(control)
   self.control = control

   self.board = Board()
   self.squareSize = display.contentWidth / 9

   self.dropSquare = Square(5, 1, 'green', self.board)

   -- display.setDefault( "background", 0, 0, 0 )
   -- display.setDefault( "background", 255, 255, 255 )
end


function MainGame:mainGameLoop()
   if self.board:isGameOver() then return end

   if self.control.x then
      self.dropSquare:moveTo(self.control.x)
   end
   if self.control.endTouch then
      self.control.endTouch = nil
      self.dropSquare:drop()
   end

   if self.dropSquare.dropped then
      self.dropSquare = Square(5, 1, 'red', self.board)
   end

   self.dropSquare:update()
end
