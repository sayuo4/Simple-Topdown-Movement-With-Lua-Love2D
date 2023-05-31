Player = {}

function Player.load()
   Player.scale = 25
   Player.position = {x = 300, y = 300}
   Player.speed = 350
end

function Player.update(dt)
   Player.position = {
      x = Player.position.x + GetKeyAxis("right", "left") * Player.speed * dt,
      y = Player.position.y + GetKeyAxis("down", "up") * Player.speed * dt
   }
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