module(..., package.seeall)

require "square"

function setup()
   square = Square(5, 1, 'green', Board())
end

function test_the_square_can_drop()
   local startY = square.square.y
   square:drop()
   square:update()
   assert_gt(startY, square.square.y)
end

function test_the_square_stops_dropping_at_bottom_of_board()
   square:drop()
   for x=0,100 do
      square:update()
   end

   assert_equal(display.contentHeight - square.squareSize / 2, square.square.y)
   assert_equal(12, square.gridY)
   assert_equal(square, square.board:getSquare(square.gridX, square.gridY))
end

function test_the_square_lands_on_top_of_other_squares()
   square.board:setSquare(Square(5, 12, 'green', square.board))
   square:drop()
   for x=0,100 do
      square:update()
   end

   assert_equal(display.contentHeight - square.squareSize / 2 - square.squareSize, square.square.y)
   assert_equal(11, square.gridY)
   assert_equal(square, square.board:getSquare(square.gridX, square.gridY))
end

