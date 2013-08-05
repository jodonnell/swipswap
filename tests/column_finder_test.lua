module(..., package.seeall)

require "board"
require "column_finder"
_ = require "underscore"

function setup()
  board = Board()
  columnFinder = ColumnFinder(board)
end

function test_the_board_can_find_three_in_a_column()
  board:newSquareInRow(1, Block(1, SQUARE_START_Y, Square('random'), board))
  board:newSquareInRow(1, Block(1, SQUARE_START_Y, Ghost('random'), board))
  
  board.board[1][1].color = 'red'
  board.board[1][2].color = 'red'
  board.board[1][3].color = 'red'

  board.board[1][1].color = 'red'
  board.board[1][2]:setY(board.board[1][1]:y() - SQUARE_SIZE)
  board.board[1][3]:setY(board.board[1][2]:y() - SQUARE_SIZE)

  local squares = columnFinder:find()

  assert_true(_.include(squares, board.board[1][1]))
  assert_true(_.include(squares, board.board[1][2]))
  assert_true(_.include(squares, board.board[1][3]))
end

function test_the_board_can_find_three_in_columns()
  board:newSquareInRow(1, Block(1, SQUARE_START_Y, Square('random'), board))
  board:newSquareInRow(1, Block(1, SQUARE_START_Y, Ghost('random'), board))

  board:newSquareInRow(2, Block(2, SQUARE_START_Y, Square('random'), board))
  board:newSquareInRow(2, Block(2, SQUARE_START_Y, Ghost('random'), board))
  
  board.board[1][1].color = 'red'
  board.board[1][2].color = 'red'
  board.board[1][3].color = 'red'

  board.board[1][1].color = 'red'
  board.board[1][2]:setY(board.board[1][1]:y() - SQUARE_SIZE)
  board.board[1][3]:setY(board.board[1][2]:y() - SQUARE_SIZE)

  board.board[2][1].color = 'red'
  board.board[2][2].color = 'red'
  board.board[2][3].color = 'red'

  board.board[2][1].color = 'red'
  board.board[2][2]:setY(board.board[2][1]:y() - SQUARE_SIZE)
  board.board[2][3]:setY(board.board[2][2]:y() - SQUARE_SIZE)

  local squares = columnFinder:find()

  assert_true(_.include(squares, board.board[1][1]))
  assert_true(_.include(squares, board.board[1][2]))
  assert_true(_.include(squares, board.board[1][3]))
  assert_true(_.include(squares, board.board[2][1]))
  assert_true(_.include(squares, board.board[2][2]))
  assert_true(_.include(squares, board.board[2][3]))
end
