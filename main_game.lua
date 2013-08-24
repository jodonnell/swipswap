require 'class'
require 'square'
require 'board'
require 'held_blocks'

MainGame = class()

function MainGame:init(control)
  self.control = control

  self.board = Board()
  self.tappedSquare = nil
  self.heldBlocks = HeldBlocks()
end


function MainGame:update()
  if self.board:isGameOver() then return end

  self:touched()
  self:endTouched()

  self.heldBlocks:update()
  self.board:update()
end

function MainGame:dropBlocks()
  self.heldBlocks:setGridX(self.control.x)
  self.heldBlocks:fall()

  _.each(_.reverse(self.heldBlocks.blocks), function(block)
    _.push(self.board:getColumn(self.control.x), block)
  end)
  self.heldBlocks:clear()
end

function MainGame:pickupBlocks()
  if self.tappedSquare == nil then
    return
  end

  -- get all squares above current square.
  -- move em up
  local blocks = self.board:getAllAbove(self.tappedSquare)

  _.times(#blocks, function()
    _.pop(self.board:getColumn(self.tappedSquare:getGridX()))
  end)

  _.each(_.reverse(blocks), function(block)
    block.isMovingUp = true
    self.heldBlocks:addBlock(block)
  end)
end

function MainGame:touched()
  if not self.control.startTouch then
    return
  end

  self.control.startTouch = nil
  self.tappedSquare = self.board:getBlockInColumnAtY(self.control.x, self.control.y)
end

function MainGame:endTouched()
  if not self.control.endTouch then
    return
  end

  if not self.heldBlocks:isEmpty() and self.heldBlocks:isMovingBlockUp() then
  elseif not self.heldBlocks:isEmpty() then
    self.control.endTouch = nil
    self:dropBlocks()
  else
    self.control.endTouch = nil
    self:pickupBlocks()
  end
end
