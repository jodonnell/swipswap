require 'class'

RowFinder = class()

function RowFinder:init(board)
  self.board = board
end

function RowFinder:find()
  local squares = {}
  for y=1,self.board:bottomOfBoard() do
    local squaresInARow = {}
    self.board:eachColumn(function(column)
      if #column.blocks >= y then
        squaresInARow = self:addOrRestartChain(column.blocks[y], squaresInARow)
      else 
        squaresInARow = {}
      end

      if #squaresInARow >= 3 then
        squares = _.concat(squares, squaresInARow)
      end
    end)
  end
  return squares
end

function RowFinder:addOrRestartChain(square, squaresInARow)
  if square.isFalling then
    return {}
  end

  if #squaresInARow > 0 and squaresInARow[1].color == square.color then
    _.push(squaresInARow, square)
  else
    squaresInARow = {square}
  end
  return squaresInARow
end
