require 'class'
require 'square'
require 'board'
require 'grid_conversion'

MainGame = class()
gridConversion = GridConversion()

function MainGame:init(control)
   self.control = control

   self.board = Board()

   self.dropSquare = Square(5, 1, 'random', self.board)

   -- display.setDefault( "background", 0, 0, 0 )
   -- display.setDefault( "background", 255, 255, 255 )
end


function MainGame:mainGameLoop()
   if self.board:isGameOver() then return end

   if self.dropSquare.isDropping == false then
      if self.control.x then
         self.dropSquare:moveTo(self.control.x)
      end

      if self.control.endTouch then
         self.control.endTouch = nil
         self.dropSquare:drop()
      end
   end

   if self.dropSquare.dropped then
      self.dropSquare = Square(5, 1, 'random', self.board)
   end

   self.dropSquare:update()
   self.board:update()
end
