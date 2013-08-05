require 'class'
require 'global'

Ghost = class()

function Ghost:init(color)
  self:setColor(color)
  self.square:scale(0.333333, 0.333333333)
end

function Ghost:setColor(color)
  if color == 'random' then
    color = _.first(_.shuffle({'green', 'yellow', 'red', 'blue', 'pink', 'cyan'}))
    --color = _.first(_.shuffle({'green', 'yellow', 'red'}))
  end

  self.color = color
  self.square = display.newImage(self.color .. "_closed.png")
end

function Ghost:uncovered(block)
  block.isRushing = true
end
