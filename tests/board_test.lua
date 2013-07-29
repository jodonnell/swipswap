module(..., package.seeall)

require "board"
_ = require "underscore"

function setup()
  board = Board()
end

function test_starts_with_a_row()
  for i = 1, board:rightOfBoard() do
    assert_equal(1, #board:getRow(i))
  end
end

function test_can_get_all_squares()
  assert_equal(board:rightOfBoard(), #board:allSquares())

  _.each(board:allSquares(), function(square)
    assert_true(square:is_a(Square))
  end)
end 

function test_shouldCreateNewRow()
  board.tick = SQUARE_SIZE * 4 - 1
  assert_false(board:shouldCreateNewRow())

  board.tick = SQUARE_SIZE * 4
  assert_true(board:shouldCreateNewRow())
end 

function test_createNewRow()
  assert_equal(board:rightOfBoard(), #board:allSquares())
  board:createNewRow()
  assert_equal(board:rightOfBoard() * 2, #board:allSquares())
end

function test_newSquareInRow()
  assert_equal(1, #board:getRow(1))
  board:newSquareInRow(1)
  assert_equal(2, #board:getRow(1))
end


function test_update()
  board.shouldCreateNewRow = function() return true end
  board:update()
  assert_equal(board:rightOfBoard() * 2, #board:allSquares())
end

function test_the_board_can_find_three_in_a_row()
  board.board[1][1].color = 'red'
  board.board[2][1].color = 'red'
  board.board[3][1].color = 'red'

  local squares = board:findSquaresInARow()

  assert_true(_.include(squares, board.board[1][1]))
  assert_true(_.include(squares, board.board[2][1]))
  assert_true(_.include(squares, board.board[3][1]))
end

function test_the_board_does_not_false_postive()
  board.board[1][1].color = 'red'
  board.board[2][1].color = 'green'
  board.board[3][1].color = 'red'
  board.board[4][1].color = 'yellow'
  board.board[5][1].color = 'yellow'

  local squares = board:findSquaresInARow()

  assert_false(_.include(squares, board.board[1][1]))
  assert_false(_.include(squares, board.board[2][1]))
  assert_false(_.include(squares, board.board[3][1]))
end

-- function test_the_squares_must_be_contiguous()
--   square1 = Square(1, 1, 'red', board)
--   square2 = Square(2, 1, 'red', board)
--   square3 = Square(3, 1, 'red', board)

--   square5 = Square(5, 1, 'red', board)

--   board:setSquare(square1)
--   board:setSquare(square2)
--   board:setSquare(square3)
--   board:setSquare(square5)

--   local squares = board:findSquaresInARow()

--   assert_false(_.include(squares, square5))
-- end
