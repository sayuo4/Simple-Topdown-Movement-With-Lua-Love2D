Spawner = {}

local timer = 0.5
local spawnDirs = {"up", "down", "right", "left"}
local spawnDir = spawnDirs[1]

function Spawner.load()
   spawnDir = spawnDirs[math.random(#spawnDirs)]
end

function Spawner.update(dt)
   timer = timer - dt
   if timer <= 0 then
      spawnDir = spawnDirs[math.random(#spawnDirs)]
      -- local 
      if spawnDir == "up" then
         Enemy.addEnemy(math.random(_G.windowProps.width), 0)
      elseif spawnDir == "down" then
         Enemy.addEnemy(math.random(_G.windowProps.width), _G.windowProps.height)
      elseif spawnDir == "right" then
         Enemy.addEnemy(_G.windowProps.width, math.random(_G.windowProps.height))
      elseif spawnDir == "left" then
         Enemy.addEnemy(0, math.random(_G.windowProps.height))
      end
      timer = 0.5
   end
end