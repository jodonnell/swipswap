module(..., package.seeall)

require "square"

function setup()
   square = Square(5, 1, 'green', Board())
end
