module(..., package.seeall)

require "main_game"
require "control"

function setup()
  mainGame = MainGame(Control())
end

function test_that_swiping_on_a_block_lifts_it_to_top()
  assert_equal(1, #mainGame.board:getColumn(1))

  mainGame.control.x = 1
  mainGame.control.y = mainGame.board:bottomOfBoard()
  mainGame.control.startTouch = true

  mainGame:update()

  mainGame.control.x = 2
  mainGame:update()

  assert_equal(1, #mainGame.board:getColumn(1))

  mainGame.control.endTouch = true
  mainGame:update()

  assert_equal(0, #mainGame.board:getColumn(1))
  assert_equal(2, #mainGame.board:getColumn(2))
end
