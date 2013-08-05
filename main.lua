require "main_game"
require 'control'
require 'global'

if os.getenv("LUA_TEST") then
  require "lunatest.lunatest"

  lunatest.suite("tests.main_game_test")
  lunatest.suite("tests.block_test")
  lunatest.suite("tests.board_test")
  lunatest.suite("tests.row_finder_test")
  lunatest.suite("tests.column_finder_test")

  lunatest.run()
  os.exit()
end

display.setStatusBar( display.HiddenStatusBar )

control = Control()
local mainGame = MainGame(control)

function loop()
  mainGame:update()
end

Runtime:addEventListener( "enterFrame", loop )

local function onScreenTouch( event )
  if event.phase == "began" then
    control.x = pixelsToGrid(event.x)
    control.y = event.y
    control.startTouch = true
  elseif event.phase == "moved" then
    control.x = pixelsToGrid(event.x)
    control.y = event.y
  elseif event.phase == "ended" or event.phase == "cancelled" then
    control.x = pixelsToGrid(event.x)
    control.y = event.y
    control.endTouch = true
  end

  return true
end

Runtime:addEventListener( "touch", onScreenTouch )
