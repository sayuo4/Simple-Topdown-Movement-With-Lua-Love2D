Debugger = {}

local hideDebugger = false
local textScale    = 1.25
local excludedEnteries = {"objectsToPrint", "objectsAsString", "windowProps"}

function Debugger.load()
   Debugger.data = {
      ["FPS"] = 0.0,
      ["frameTime"] = 0.0,
      ["totalRuntime"] = 0.0,
      ["windowProps"] = "",
      ["objectsToPrint"] = {},
      ["objectsAsString"] = "",
   }
end

function Debugger.update(dt)
   Debugger.data["FPS"] = love.timer.getFPS()
   Debugger.data["frameTime"] = love.timer.step()
   Debugger.data["totalRuntime"] = love.timer.getTime()
   Debugger.data["windowProps"] = tableToString(_G.windowProps, true, false)
   Debugger.data["objectsAsString"] = tableToString(Debugger.data["objectsToPrint"], true, false)
end
 
function Debugger.draw()
   if hideDebugger == true then
      goto endOfDrawFunc
   end
   
   local padding = {x = 10, y = 10}
   local textToRender = ""
   
   for key,val in pairs(Debugger.data) do
      -- "Comment-out" the `excludedEnteries` from the text rendering, because they're too long, or for other reasons
      for i=1, #excludedEnteries do
         if key == excludedEnteries[i] then
            goto endOfPrintLoop
         end
      end
      textToRender = textToRender .. key .. ": " .. tostring(val) .. "\n"
      ::endOfPrintLoop::
   end
   
   love.graphics.setColor(1, 1, 1)
   love.graphics.print(
      {{1, 1, 1}, textToRender},
      padding.x, padding.y, 0,
      textScale
   )
   ::endOfDrawFunc::
end

function Debugger.printObject(key, value)
   Debugger.data["objectsToPrint"][key] = value
end

function Debugger.toggle()
   hideDebugger = not hideDebugger
end

function Debugger.changeTextScaleBy(delta)
   textScale = textScale + delta
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