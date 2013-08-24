require 'class'
_ = require 'underscore'


Column = class()

function Column:init(blocks)
  self.blocks = blocks
end

function Column:each(func)
  _.each(self.blocks, func)
end

function Column:getAllAbove(block)
  return _.filter(self.blocks, function(blockInColumn)
    return blockInColumn:y() <= block:y()
  end)
end

function Column:getTop()
  return self.blocks[#self.blocks]
end

function Column:getBottom()
  return self.blocks[1]
end

function Column:isEmpty()
  return #self.blocks == 0
end

function Column:addBlock(block)
  _.unshift(self.blocks, block)
end

function Column:addBlockToTop(block)
  _.push(self.blocks, block)
end

function Column:removeFromTop()
  return _.pop(self.blocks)
end

function Column:removeBlock(blockToRemove)
  self.blocks = _.reject(self.blocks, function(block) 
    return block == blockToRemove 
  end)
end

function Column:checkForSquaresToBeginFalling()
  if #self.blocks > 1 then
    for y=2, #self.blocks do
      if math.abs(self.blocks[y]:y() - self.blocks[y - 1]:y()) > SQUARE_SIZE then
        self.blocks[y].isFalling = true
      end
    end
  end
end

function Column:checkForSquaresToEndFalling()
  if #self.blocks > 1 then
    for y=2, #self.blocks do
      if math.abs(self.blocks[y]:y() - self.blocks[y - 1]:y()) < SQUARE_SIZE then
        self.blocks[y].isFalling = false
        self.blocks[y]:setY(self.blocks[y - 1]:y() - SQUARE_SIZE)
      end
    end
  end
end
