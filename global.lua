SQUARE_SIZE = display.contentWidth / 9

function gridToPixels(pos)
  return (pos - 1) * SQUARE_SIZE + SQUARE_SIZE / 2
end

function pixelsToGrid(pixels)
  return math.floor(pixels / (SQUARE_SIZE)) + 1
end
