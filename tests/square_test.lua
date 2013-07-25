module(..., package.seeall)

require "square"

function setup()
   square = Square(5, 1, 'green', Board())
end

function test_goto_top()
   square:goToTop()
   square:update()
   square
end