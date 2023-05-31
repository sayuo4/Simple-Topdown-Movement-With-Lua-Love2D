Spawner = {}

local timer = 0.5
local spawnDirs = {"up", "down", "right", "left"}
local spawnDir = spawnDirs[1]

function Spawner.load()

end

function Spawner.update(dt)
    timer = timer - dt
    if timer <= 0 then
        spawnDir = spawnDirs[math.random(4)]
        if spawnDir == "up" then
            Enemy.addEnemy(math.random(800), 0)
        elseif spawnDir == "down" then
            Enemy.addEnemy(math.random(800), 600)
        elseif spawnDir == "right" then
            Enemy.addEnemy(800, math.random(600))
        elseif spawnDir == "left" then
            Enemy.addEnemy(0, math.random(600))
        end
        timer = 0.5
    end
end