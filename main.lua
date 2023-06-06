require "playerController"
require "enemiesController"
require "enemiesSpawner"
require "debugger"

function love.load()
   math.randomseed(os.time())
   Player.load()
   Enemy.load()
   Spawner.load()
   Debugger.load()
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
   Player.draw()
   Enemy.draw()
   Debugger.draw()
end