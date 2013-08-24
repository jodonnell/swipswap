require 'class'

RowFinder = class()

function RowFinder:init(board)
  self.board = board
end

function RowFinder:find()
  local squares = {}
  for y=1,self.board:bottomOfBoard() do
    local squaresInARow = {}
    for x=1,self.board:rightOfBoard() do
      if #self.board:getColumn(x).blocks >= y then
        squaresInARow = self:addOrRestartChain(self.board:getColumn(x).blocks[y], squaresInARow)
      else 
        squaresInARow = {}
      end

      if #squaresInARow >= 3 then
        squares = _.concat(squares, squaresInARow)
      end
    end
  end
  return squares
end

function RowFinder:addOrRestartChain(square, squaresInARow)
  if #squaresInARow > 0 and squaresInARow[1].color == square.color then
    _.push(squaresInARow, square)
  else
    squaresInARow = {square}
  end
  return squaresInARow
end
