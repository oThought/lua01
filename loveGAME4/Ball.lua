local love = require "love"

function Ball(x, y, movement, radius)
    return {
        checkCollision = function(self, blockX, blockY, blockWidth, blockHeight)
            for i = 0, math.pi * 2, math.pi / 180 do
                if withinRectangle(x + math.cos(i) * radius, y + math.sin(i) * radius, blockX, blockY, blockWidth, blockHeight) then
                    return true
                end
            end
            return false
        end,

        checkOut = function(self)
            if x <= 60 or x >= 540 then return true end
        end,

        wallBounce = function(self) 
            if y <= radius then return math.pi * 2 - movement end
            if y >= 600 - radius then return math.pi * 2 - movement end
            return 0
        end, 
        
        draw = function(self)
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", x, y, radius)
        end
    }
end

function withinRectangle(x, y, rectX, rectY, w, h)
    if x >= rectX and y >= rectY and x <= rectX + w and y <= rectY + h then return true end
    return false
end

return Ball