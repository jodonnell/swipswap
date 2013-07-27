require 'class'

GridConversion = class()

function GridConversion:init()
  self.squareSize = display.contentWidth / 9
end

function GridConversion:gridToPixels(pos)
  return (pos - 1) * self.squareSize + self.squareSize / 2
end

function GridConversion:pixelsToGrid(pixels)
  return math.floor(pixels / (self.squareSize)) + 1
end

