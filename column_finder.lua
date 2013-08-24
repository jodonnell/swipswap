require 'class'

ColumnFinder = class()

function ColumnFinder:init(board)
  self.board = board
end

function ColumnFinder:find()
  local squares = {}
  self.board:eachColumn(function(column)
    local squaresInColumn = self:findSquaresInAColumn(column)
    squares = _.concat(squares, squaresInColumn)
  end)
  return squares
end

function ColumnFinder:findSquaresInAColumn(column)
  local squares = {}
  local squaresInARow = {}
  _.each(column.blocks, function(square)
    squaresInARow = self:addOrRestartChain(square, squaresInARow)
    if #squaresInARow >= 3 then
      squares = _.concat(squares, squaresInARow)
    end
  end)
  return squares
end

function ColumnFinder:addOrRestartChain(square, squaresInARow)
  if #squaresInARow > 0 and squaresInARow[1].color == square.color then
    _.push(squaresInARow, square)
  else
    squaresInARow = {square}
  end
  return squaresInARow
end
