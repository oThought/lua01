local love = require "love"

function Button(text, f, parameter, buttonX, buttonY, width, height, textX, textY)
    return {
        --f = f or function() print("not defined") end,
        checkPressed = function(self, mouseX, mouseY, cursorRadius)
            for i = 0, math.pi * 2, math.pi / 180 do
                checkX = mouseX + math.cos(i) * cursorRadius
                checkY = mouseY + math.sin(i) * cursorRadius
                if (checkX >= buttonX and checkX <= buttonX + width) and (checkY >= buttonY and checkY <= buttonY + height) then
                    if parameter then
                        f(parameter)
                    else 
                        f()
                    end
                end
            end
        end,
        
        draw = function(self)
            love.graphics.setColor(0.6, 0.6, 0.6)
            love.graphics.rectangle("fill", buttonX, buttonY, width, height)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(text, buttonX + textX, buttonY + textX)
            love.graphics.setColor(1, 1, 1)
        end
    }
end

return Button