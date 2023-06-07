require "playerController"
require "enemiesController"
require "enemiesSpawner"
require "debugger"

local initWinSize = {x = 800, y = 600}
local newWinFlags = {
   resizable = true, vsync = 0, msaa = 4,
   minwidth = 400, minheight = 300
}
_G.windowProps = {width = 0, height = 0, flags = {}}

local helpMsg = [[
              Press `escape` to quit the game
  Press the back-tick/grave key '`' to toggle the debugger
Increase debugger text size by pressing =/- keys respectively
]]


function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   elseif key == "`" then
      Debugger.toggle()
   elseif key == "=" then
      Debugger.changeTextScaleBy(0.25)
   elseif key == "-" then
      Debugger.changeTextScaleBy(-0.25)
   end
end

function love.resize()
   print("Window Resized, updating the Global `windowProps` variable")
   _G.windowProps.width, _G.windowProps.height, _G.windowProps.flags = love.window.getMode()
end

function love.load()
   -- Initialize Game Window
   setupGameWindow()
   _G.windowProps.width  = initWinSize.x
   _G.windowProps.height = initWinSize.y
   _G.windowProps.flags  = newWinFlags
   -- Load necessary Object(s) by calling `.load()` method on each "class"
   math.randomseed(os.time())
   Player.load()
   Enemy.load()
   Spawner.load()
   Debugger.load()
   -- Debugging Section
   Debugger.printObject("player", Player)
   Debugger.printObject("enemy", Enemy)
end

function love.update(dt)
   Player.update(dt)
   Enemy.update(dt)
   Spawner.update(dt)
   Debugger.update(dt)
end

function love.draw()
   printMsg(
      helpMsg, {1, 1, 1},
      {x = _G.windowProps.width/3.25, y = 20}, 1.25
   )
   Player.draw()
   Enemy.draw()
   Debugger.draw()
end

function setupGameWindow()
   isSuccessed = love.window.setMode(
      initWinSize.x, initWinSize.y, newWinFlags
   )
   if isSuccessed == true then
      print("Successfully Initialized a New Game Window")
   else
      print("Failed to Initialize New Game Window :(\nExiting program...")
      love.event.quit()
   end
end

function printMsg(msg, color, offset, scallingFactor)
   love.graphics.setColor(1, 1, 1)
   love.graphics.print(
      {color, msg},
      offset.x, offset.y, 0,
      scallingFactor
   )
end