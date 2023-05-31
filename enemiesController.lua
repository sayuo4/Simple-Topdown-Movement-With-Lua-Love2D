Enemy = {}
local enemies = {}

function Enemy.load()
    Enemy.scale = 25
    Enemy.speed = 850
end

function Enemy.update(dt)
    Enemy.playerPosition = Player.position
    for updatedEnemy = 1, #enemies do
        enemies[updatedEnemy].x = enemies[updatedEnemy].x + (enemies[updatedEnemy].dx * dt)
        enemies[updatedEnemy].y = enemies[updatedEnemy].y + (enemies[updatedEnemy].dy * dt)
    end
end

function Enemy.draw()
    for drawedEnemy = 1, #enemies do
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("fill", enemies[drawedEnemy].x, enemies[drawedEnemy].y, Enemy.scale)
    end

end

function Enemy.addEnemy(enemyPosX, enemyPosY)
    local angle = math.atan2(
        (Enemy.playerPosition.y - enemyPosY),
        (Enemy.playerPosition.x - enemyPosX)
    )
    local dir = {
        x = Enemy.speed * math.cos(angle),
        y = Enemy.speed * math.sin(angle)
    }
    table.insert(enemies, {x = enemyPosX, y = enemyPosY, dx = dir.x, dy = dir.y})
end