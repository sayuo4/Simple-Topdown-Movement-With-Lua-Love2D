Debugger = {}

function Debugger.load()
   Debugger.fps = 0.0
   Debugger.frame_time = 0.0
   Debugger.total_runtime = 0.0
   -- TODO: Add a feature which prints all elements of objects inside this table/list --
   Debugger.objects_to_print = {}
end

function Debugger.update(dt)
   Debugger.fps = love.timer.getFPS()
   Debugger.frame_time = love.timer.step()
   Debugger.total_runtime = love.timer.getTime()
end
 
function Debugger.draw()
   -- TODO: This code can be improved upon by alot. --
   local padding = {x = 10, y = 10}
   local scalling_factor = 1.5
   love.graphics.setColor(1, 1, 1)
   
   love.graphics.print(
      {{1, 1 * (Debugger.fps / 60), 1}, "FPS: " .. tostring(Debugger.fps)},
      padding.x, padding.y, 0,
      scalling_factor
   )
   love.graphics.print(
      {{1, 1, 1}, "Frame Time (in seconds): " .. tostring(Debugger.frame_time)},
      padding.x, padding.y + (30 * 1), 0,
      scalling_factor
   )
   love.graphics.print(
      {{1, 1, 1}, "Total Tuntime (in seconds): " .. tostring(Debugger.total_runtime)},
      padding.x, padding.y + (30 * 2), 0,
      scalling_factor
   )
end