module(..., package.seeall)

require "board"
_ = require "underscore"

function setup()
   board = Board()
end

function test_starts_with_a_row()
   local bottom = board:bottomOfBoard()

   for i= 1, board:rightOfBoard() do
      assert_true(board:getSquare(i, bottom))
   end
end

function test_slowly_gains_new_row()
   local bottom = board:bottomOfBoard()
   assert_false(board:getSquare(1, bottom - 1))

   for i= 1, 200 do
      board:update()
   end
   assert_true(board:getSquare(1, bottom - 1))
end


function test_the_board_can_find_three_in_a_row()
   square1 = Square(1, 1, 'red', board)
   square2 = Square(2, 1, 'red', board)
   square3 = Square(3, 1, 'red', board)

   board:setSquare(square1)
   board:setSquare(square2)
   board:setSquare(square3)

   local squares = board:findSquaresInARow()

   assert_true(_.include(squares, square1))
   assert_true(_.include(squares, square2))
   assert_true(_.include(squares, square3))
end

function test_the_board_does_not_false_postive()
   square1 = Square(1, 1, 'red', board)
   square2 = Square(2, 1, 'green', board)
   square3 = Square(3, 1, 'red', board)

   board:setSquare(square1)
   board:setSquare(square2)
   board:setSquare(square3)

   local squares = board:findSquaresInARow()

   assert_false(_.include(squares, square1))
   assert_false(_.include(squares, square2))
   assert_false(_.include(squares, square3))

end

function test_the_squares_must_be_contiguous()
   square1 = Square(1, 1, 'red', board)
   square2 = Square(2, 1, 'red', board)
   square3 = Square(3, 1, 'red', board)

   square5 = Square(5, 1, 'red', board)

   board:setSquare(square1)
   board:setSquare(square2)
   board:setSquare(square3)
   board:setSquare(square5)

   local squares = board:findSquaresInARow()

   assert_false(_.include(squares, square5))
end
