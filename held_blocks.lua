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
  _.each(self.blocks, function(block)
    block:update()
  end)
end

function HeldBlocks:isMovingBlockUp()
  return self.blocks[1].isMovingUp
end

function HeldBlocks:setGridX(x)
  self.blocks[1]:setGridX(x)
end

function HeldBlocks:fall()
  self.blocks[1].isFalling = true
end
