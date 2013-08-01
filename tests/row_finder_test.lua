module(..., package.seeall)

require "board"
require "row_finder"
_ = require "underscore"

function setup()
  board = Board()
  rowFinder = RowFinder(board)
end


function test_the_board_can_find_three_in_a_row()
  board.board[1][1].color = 'red'
  board.board[2][1].color = 'red'
  board.board[3][1].color = 'red'

  local squares = rowFinder:find()

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

  local squares = rowFinder:find()

  assert_false(_.include(squares, board.board[1][1]))
  assert_false(_.include(squares, board.board[2][1]))
  assert_false(_.include(squares, board.board[3][1]))
end

function test_the_squares_must_be_contiguous()
  board.board[1][1].color = 'red'
  board.board[2][1].color = 'red'
  board.board[3][1].color = 'red'
  board.board[4][1].color = 'yellow'
  board.board[5][1].color = 'red'
  board.board[6][1].color = 'yellow'

  local squares = rowFinder:find()

  assert_false(_.include(squares, board.board[5][1]))
end
