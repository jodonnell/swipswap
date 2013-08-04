module(..., package.seeall)

require "board"
_ = require "underscore"

function setup()
  board = Board()
end

function test_starts_with_a_row()
  for i = 1, board:rightOfBoard() do
    assert_equal(1, #board:getColumn(i))
  end
end

function test_can_get_all_squares()
  assert_equal(board:rightOfBoard(), #board:allSquares())

  _.each(board:allSquares(), function(square)
    assert_true(square:is_a(Block))
  end)
end 

function test_shouldCreateNewRow()
  board.tick = SQUARE_SIZE * GAME_SPEED - 1
  assert_false(board:shouldCreateNewRow())

  board.tick = SQUARE_SIZE * GAME_SPEED
  assert_true(board:shouldCreateNewRow())
end 

function test_createNewRow()
  assert_equal(board:rightOfBoard(), #board:allSquares())
  board:createNewRow()
  assert_equal(board:rightOfBoard() * 2, #board:allSquares())
end

function test_newSquareInRow()
  assert_equal(1, #board:getColumn(1))
  board:newSquareInRow(1)
  assert_equal(2, #board:getColumn(1))
end

function test_clearSquare()
  local removeSquare = board.board[1][1]
  board:clearSquare(removeSquare)
  assert_equal(0, #board.board[1])
end

function test_removeSquares()
  local square = board.board[1][1]
  local called = false
  square.startDisappearing = function() called = true end
  board:removeSquares({square})

  assert_true(called)
end

function test_checkForSquaresToBeginFalling()
  board:newSquareInRow(1)
  board:newSquareInRow(1)

  local square = board.board[1][3]
  square.square.y = 0

  board.board[1][2].square.y = board.board[1][1].square.y - SQUARE_SIZE

  board:checkForSquaresToBeginFalling()

  assert_true(square.isFalling)
  assert_false(board.board[1][1].isFalling)
  assert_false(board.board[1][2].isFalling)
end

function test_checkForSquaresToEndFalling()
  board:newSquareInRow(1)

  local square = board.board[1][2]
  square.isFalling = true
  square:setY(board.board[1][1]:y() - SQUARE_SIZE + 1)

  board:checkForSquaresToEndFalling()

  assert_false(square.isFalling)
  assert_equal(board.board[1][1]:y() - SQUARE_SIZE, square:y())
end

-- function test_squares_fall_when_there_is_nothing_underneath_them()
--   local square = board:getTopOfColumn(1)
--   square:setY(100)

--   board:checkForSquaresToBeginFalling()

--   assert_true(square.isFalling)
-- end

function test_update()
  board.shouldCreateNewRow = function() return true end
  board:update()
  assert_equal(board:rightOfBoard() * 2, #board:allSquares())
end

function test_getTopOfColumn()
  board:newSquareInRow(1)
  assert_equal(board:getColumn(1)[2], board:getTopOfColumn(1))
end
