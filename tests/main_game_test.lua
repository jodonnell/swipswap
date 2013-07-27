module(..., package.seeall)

require "main_game"
require "control"

function setup()
  mainGame = MainGame(Control())
end

function test_that_swiping_on_a_block_lifts_it_to_top()
  assert_true(mainGame.board:getSquare(1, mainGame.board:bottomOfBoard()))

  mainGame.control.x = 1
  mainGame.control.y = mainGame.board:bottomOfBoard()
  mainGame.control.startTouch = true

  mainGame:update()

  mainGame.control.y = mainGame.board:bottomOfBoard() - 1
  mainGame:update()

  assert_true(mainGame.board:getSquare(1, mainGame.board:bottomOfBoard()))

  mainGame.control.endTouch = true
  mainGame:update()

  assert_false(mainGame.board:getSquare(1, mainGame.board:bottomOfBoard()))
end
