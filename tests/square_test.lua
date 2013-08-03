module(..., package.seeall)

require "square"

function setup()
  square = Square(5, 1, 'green', Board())
end

function test_setGridX()
  square:setGridX(2)
  assert_equal(2, square.gridX)
  assert_equal(gridToPixels(2), square:x())
end


function test_update()
  square:setY(100)
  local y = square:y()
  square:update(false)
  assert_equal(y, square:y())

  square:update(true)
  assert_equal(y - 1, square:y())

  y = square:y()
  square.isFalling = true
  square:update(true)
  assert_equal(y + 10, square:y())

  y = square:y()
  square.isFalling = false
  square.isMovingUp = true
  square:update(true)
  assert_equal(y - 10, square:y())

end

function test_x()
  assert_equal(gridToPixels(5), square:x())
end

function test_y()
  assert_equal(1, square:y())
end

function test_shouldMoveUp()
  assert_true(square:shouldMoveUp(true))

  square.isFalling = true
  assert_false(square:shouldMoveUp(true))

  square.isFalling = false
  assert_false(square:shouldMoveUp(false))
end

function test_fall()
  local y = square:y()
  square:fall()
  assert_equal(y + 10, square:y())
end

function test_move_up()
  square:setY(100)
  square:moveUp()
  assert_equal(90, square:y())

  square:setY(SQUARE_SIZE / 2 + 9)
  square:moveUp()
  assert_equal(SQUARE_SIZE / 2, square:y())
  assert_false(square.isMovingUp)
end

