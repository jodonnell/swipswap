require 'class'
_ = require 'underscore'

HeldBlocks = class()

function HeldBlocks:init()
  self:clear()
end

function HeldBlocks:addBlock(block)
  _.push(self.blocks, block)
end

function HeldBlocks:isEmpty()
  return #self.blocks == 0
end

function HeldBlocks:clear()
  self.blocks = {}
end


function HeldBlocks:update()
  self:checkForSquaresToEndMovingUp()

  _.each(self.blocks, function(block)
    block:update()
  end)
end

function HeldBlocks:isMovingBlockUp()
  return self.blocks[1].isMovingUp
end

function HeldBlocks:setGridX(x)
  _.each(self.blocks, function(block)
    block:setGridX(x)
  end)
end

function HeldBlocks:fall()
  _.each(self.blocks, function(block)
    block.isFalling = true
  end)
end

function HeldBlocks:checkForSquaresToEndMovingUp()
  _.each(self.blocks, function(block, i)
    local lowestY = SQUARE_SIZE / 2 + SQUARE_SIZE * (i - 1)
    if block:y() < lowestY then
      block.square.y = lowestY
      block.isMovingUp = false
    end
  end)
end
