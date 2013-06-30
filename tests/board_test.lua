module(..., package.seeall)

require "board"

function setup()
   board = Board()
end

function test_the_board_can_find_three_in_a_row()
   square1 = Square(1, 1, 'red', board)
   square2 = Square(2, 1, 'red', board)
   square3 = Square(3, 1, 'red', board)

   board:setSquare(square1)
   board:setSquare(square2)
   board:setSquare(square3)

   board:update()

   assert_true(square1.isFlashing)
   assert_true(square2.isFlashing)
   assert_true(square3.isFlashing)
end

function test_the_board_does_not_false_postive()
   square1 = Square(1, 1, 'red', board)
   square2 = Square(2, 1, 'green', board)
   square3 = Square(3, 1, 'red', board)

   board:setSquare(square1)
   board:setSquare(square2)
   board:setSquare(square3)

   board:update()

   assert_false(square1.isFlashing)
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

   board:update()

   assert_false(square5.isFlashing)
end
