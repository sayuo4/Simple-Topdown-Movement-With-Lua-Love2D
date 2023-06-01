Player = {}

function Player.load()
   Player.scale = 25
   Player.position = {x = 300, y = 300}
   Player.speed = 350
end

function Player.update(dt)
   local horizontalDirection = GetKeyAxis("right", "left")
   local verticalDirection = GetKeyAxis("down", "up")
   local normalizeAmount = math.sqrt(horizontalDirection ^ 2 + verticalDirection ^ 2)
   if normalizeAmount > 0 then
      Player.position = {
         x = Player.position.x + (horizontalDirection/normalizeAmount) * Player.speed * dt,
         y = Player.position.y + (verticalDirection/normalizeAmount) * Player.speed * dt
      }
   end
end
 
function Player.draw()
   love.graphics.setColor(1, 1, 1)
   love.graphics.circle("fill", Player.position.x, Player.position.y, Player.scale)
end
 
function GetKeyAxis(positiveButton, negativeButton)
   if love.keyboard.isDown(positiveButton) and not love.keyboard.isDown(negativeButton) then
      return 1
   elseif love.keyboard.isDown(negativeButton) and not love.keyboard.isDown(positiveButton) then
      return -1
   end
   return 0
end