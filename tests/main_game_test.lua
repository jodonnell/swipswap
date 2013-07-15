module(..., package.seeall)

require "main_game"
require "control"

function setup()
   mainGame = MainGame(Control())
end

function test_starts_with_a_row()
   local endSpot = mainGame.board:endOfBoard()

   for i= 1, mainGame.board:bottomOfBoard() do
      assert_true(mainGame.board:isSpotFilled(mainGame.board:endOfBoard(), i))
   end
end

