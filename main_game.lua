require 'class'
require 'square'
require 'board'
require 'grid_conversion'

MainGame = class()
gridConversion = GridConversion()

function MainGame:init(control)
   self.control = control

   self.board = Board()
end


function MainGame:mainGameLoop()
   if self.board:isGameOver() then return end

   self.board:update()
end
