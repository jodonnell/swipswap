require 'class'
require 'global'

Square = class()

function Square:init(color)
  self.square = display.newRoundedRect(0, 0, SQUARE_SIZE, SQUARE_SIZE, 4)
  self:setColor(color)
  self.square:setStrokeColor(255, 255, 255)
  self.square.strokeWidth = 1
end

function Square:setColor(color)
  if color == 'random' then
    color = _.first(_.shuffle({'green', 'yellow', 'red', 'blue', 'pink', 'cyan'}))
    --color = _.first(_.shuffle({'green', 'yellow', 'red'}))
  end

  self.color = color
  if color == 'red' then
    self.square:setFillColor(255, 0, 0)
  elseif color == 'yellow' then
    self.square:setFillColor(255, 255, 0)
  elseif color == 'pink' then
    self.square:setFillColor(255, 0, 255)
  elseif color == 'green' then
    self.square:setFillColor(0, 255, 0)
  elseif color == 'cyan' then
    self.square:setFillColor(0, 255, 255)
  elseif color == 'blue' then
    self.square:setFillColor(0, 0, 255)
  end

end

function Square:uncovered(block)

end
