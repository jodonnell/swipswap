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
  local y = square:y()
  square:update(false)
  assert_equal(y, square:y())

  square:update(true)
  assert_equal(y - 1, square:y())
end

function test_x()
  assert_equal(gridToPixels(5), square:x())
end

function test_y()
  assert_equal(1, square:y())
end

