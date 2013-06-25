require 'class'

GridConversion = class()

function GridConversion:init()
	 self.squareSize = display.contentWidth / 9
end

function GridConversion:convert(pos)
	 return (pos - 1) * self.squareSize + self.squareSize / 2
end
