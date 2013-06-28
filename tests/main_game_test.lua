module(..., package.seeall)

require "main_game"
require "control"

function setup()
   mainGame = MainGame(Control())
end

function test_there_is_a_drop_square()
	 assert_table(mainGame.dropSquare)
end

function test_can_move_drop_square_along_the_top()
	 mainGame.control.x = 5
   mainGame.control.y = 1

	 mainGame:mainGameLoop()

	 mainGame.control.x = 6
   mainGame.control.y = 2
	 mainGame:mainGameLoop()

	 assert_equal(6, mainGame.dropSquare.gridX)
	 assert_equal(1, mainGame.dropSquare.gridY)
end

function test_when_dropped_falls()
	 local startY = mainGame.dropSquare.square.y
	 mainGame.control.endTouch = true
	 mainGame:mainGameLoop()

	 assert_gt(startY, mainGame.dropSquare.square.y)
end

