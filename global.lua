SQUARE_SIZE = display.contentWidth / 9
SCREEN_HEIGHT = display.contentHeight
SQUARE_START_Y = SCREEN_HEIGHT + SQUARE_SIZE / 2


function gridToPixels(pos)
  return (pos - 1) * SQUARE_SIZE + SQUARE_SIZE / 2
end

function pixelsToGrid(pixels)
  return math.floor(pixels / (SQUARE_SIZE)) + 1
end
