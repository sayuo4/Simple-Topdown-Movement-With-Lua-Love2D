Debugger = {}

function Debugger.load()
   Debugger.data = {
      ["FPS"] = 0.0,
      ["frameTime"] = 0.0,
      ["totalRuntime"] = 0.0,
      ["objectsToPrint"] = {},
      ["objectsAsString"] = "",
   }
end

function Debugger.update(dt)
   Debugger.data["FPS"] = love.timer.getFPS()
   Debugger.data["frameTime"] = love.timer.step()
   Debugger.data["totalRuntime"] = love.timer.getTime()
   Debugger.data["objectsAsString"] = tableToString(Debugger.data["objectsToPrint"], true, false)
end
 
function Debugger.draw()
   local padding = {x = 10, y = 10}
   local seperateAmount = 30
   local scalling_factor = 1.5
   local numberOfEnteries = 0

   love.graphics.setColor(1, 1, 1)
   for key,val in pairs(Debugger.data) do
      -- "Comment" the 'objectsAsString' entery out of the text rendering, because it's too long
      if key ~= "objectsAsString" then
         numberOfEnteries = numberOfEnteries + 1
         love.graphics.print(
            {{1, 1, 1}, key .. ": " .. tostring(val)},
            padding.x, padding.y + seperateAmount * numberOfEnteries, 0,
            scalling_factor
         )
      end
   end
   
   love.graphics.print(
      {{1, 1, 1}, "objectsAsString" .. ": " .. tostring(Debugger.data["objectsAsString"])},
      padding.x, padding.y + seperateAmount * (numberOfEnteries + 1), 0,
      scalling_factor
   )
end

function Debugger.printObject(key, value)
   Debugger.data["objectsToPrint"][key] = value
end

function tableToString(t, prettyPrint, includeFunctions)
   local finalResult = ""
   finalResult = "{" .. recursiveTableToString(t, prettyPrint, includeFunctions)
   if type(prettyPrint) == "boolean" and prettyPrint == true then
      finalResult = finalResult .. "\n" .. "}"
   else
      finalResult = finalResult .. "}"
   end
   return finalResult
end

function recursiveTableToString(t, prettyPrint, includeFunctions, recursionLevel)
   local currentRecursionLevel = 1
   if recursionLevel ~= nil then
      currentRecursionLevel = recursionLevel + 1
   end
   local result = ""
   
   
   for k,v in pairs(t) do
      if type(v) ~= "function" then
         if type(prettyPrint) == "boolean" and prettyPrint == true then
            result = result .. "\n" .. string.rep("\t", currentRecursionLevel)
         end
         result = result .. "\"" .. k .. "\"" .. ": "
      elseif includeFunctions == true then
         if type(prettyPrint) == "boolean" and prettyPrint == true then
            result = result .. "\n" .. string.rep("\t", currentRecursionLevel)
         end
         result = result .. "\"" .. k .. "\"" .. ": "
      else
         goto endOfLoop
      end
      if type(v) ~= "table" then
         if type(v) ~= "function" then
            result = result .. tostring(v) .. ","
         elseif includeFunctions == true then
            result = result .. tostring(v) .. ","
         else
            goto endOfLoop
         end
      else
         local tempResult = "{" .. recursiveTableToString(v, prettyPrint, includeFunctions, currentRecursionLevel)
         result = result .. tempResult
         if type(prettyPrint) == "boolean" and prettyPrint == true then
            result = result .. "\n" .. string.rep("\t", currentRecursionLevel) .. "},"
         else
            result = result .. "},"
         end
      end
      ::endOfLoop::
   end
   return result
end