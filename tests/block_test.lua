module(..., package.seeall)

require "block"
require "square"

function setup()
  block = Block(5, 1, Square('green'), Board())
end

function test_setGridX()
  block:setGridX(2)
  assert_equal(2, block.gridX)
  assert_equal(gridToPixels(2), block:x())
end


function test_update()
  block:setY(100)
  local y = block:y()
  block:update(false)
  assert_equal(y, block:y())

  block:update(true)
  assert_equal(y - 1, block:y())

  y = block:y()
  block.isFalling = true
  block:update(true)
  assert_equal(y + 10, block:y())

  y = block:y()
  block.isFalling = false
  block.isMovingUp = true
  block:update(true)
  assert_equal(y - 10, block:y())

end

function test_x()
  assert_equal(gridToPixels(5), block:x())
end

function test_y()
  assert_equal(1, block:y())
end

function test_shouldMoveUp()
  assert_true(block:shouldMoveUp(true))

  block.isFalling = true
  assert_false(block:shouldMoveUp(true))

  block.isFalling = false
  assert_false(block:shouldMoveUp(false))
end

function test_fall()
  local y = block:y()
  block:fall()
  assert_equal(y + 10, block:y())
end

function test_move_up()
  block:setY(100)
  block:moveUp(10)
  assert_equal(90, block:y())
end

function test_isYInBlock()
  block:setY(100)

  assert_false(block:isYInBlock(99 - SQUARE_SIZE / 2))
  assert_true(block:isYInBlock(100 - SQUARE_SIZE / 2))

  assert_true(block:isYInBlock(100 + SQUARE_SIZE / 2))
  assert_false(block:isYInBlock(101 + SQUARE_SIZE / 2))
  
end
