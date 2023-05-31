require "playerController"
require "enemiesController"
require "enemiesSpawner"

function love.load()
   math.randomseed(os.time())
   Player.load()
   Enemy.load()
   Spawner.load()
end

function love.update(dt)
   Player.update(dt)
   Enemy.update(dt)
   Spawner.update(dt)
end

function love.draw()
   Player.draw()
   Enemy.draw()
end