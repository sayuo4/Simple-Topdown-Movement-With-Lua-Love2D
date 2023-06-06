Player = {}

function Player.load()
   Player.scale    = 25
   Player.position = {x = 300, y = 300}
   Player.speed    = 350
end

function Player.update(dt)
   local horizontal_direction = GetKeyAxis("right", "left")
   local vertical_direction = GetKeyAxis("down", "up")
   local normalize_amount = math.sqrt( horizontal_direction^2 + vertical_direction^2 )
   if normalize_amount > 0 then
      Player.position = {
         x = Player.position.x + (horizontal_direction/normalize_amount) * Player.speed * dt,
         y = Player.position.y + (vertical_direction/normalize_amount) * Player.speed * dt
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
   else
      return 0
   end
end