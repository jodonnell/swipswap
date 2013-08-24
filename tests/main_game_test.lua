module(..., package.seeall)

require "main_game"
require "control"
require "block"
require "square"

function setup()
  mainGame = MainGame(Control())
end

function test_that_swiping_on_a_block_lifts_it_to_top()
  assert_equal(1, #mainGame.board:getColumn(1))

  mainGame.control.x = 1
  mainGame.control.y = SQUARE_START_Y
  mainGame.control.startTouch = true

  mainGame:update()

  mainGame.control.y = SQUARE_START_Y - 1
  mainGame:update()

  mainGame.control.endTouch = true
  mainGame:update()

  assert_equal(0, #mainGame.board:getColumn(1))
  assert_true(mainGame.heldBlocks.blocks[1].isMovingUp)
end

function test_that_dropping_a_block_drops_it()
  assert_equal(1, #mainGame.board:getColumn(1))

  mainGame.heldBlocks:addBlock(Block(1, 0, Square('random'), mainGame.board))

  mainGame.control.x = 1
  mainGame.control.y = 1
  mainGame.control.startTouch = true

  mainGame:update()

  mainGame.control.y = 2
  mainGame:update()

  mainGame.control.endTouch = true
  mainGame:update()

  assert_equal(2, #mainGame.board:getColumn(1))
  assert_nil(mainGame.clickedOnSquare)
  assert_true(mainGame.board:getTopOfColumn(1).isFalling)
end
