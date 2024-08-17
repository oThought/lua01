local love = require "love"

function Enemy(level)
    local dice = math.random(1, 4)
    local _x, _y
    local _radius = 20

    if dice == 1 then 
        _x = math.random(_radius, love.graphics.getWidth())
        _y = -_radius * 4
    elseif dice == 2 then 
        _x = -_radius * 4
        _y = math.random(_radius, love.graphics.getHeight())
    elseif dice == 3 then 
        _x = math.random(_radius, love.graphics.getWidth())
        _y = love.graphics.getHeight() + _radius * 4
    else
        _x = love.graphics.getWidth() + _radius * 4
        _y = math.random(_radius, love.graphics.getHeight())
    end

    return {
        level = level or 1,
        radius = _radius,
        x = _x,
        y = _y,

        checkTouched = function(self, playerX, playerY, cursorRadius)
            return hypotenuse(self.x - playerX, self.y - playerY) <= cursorRadius * 2
        end,

        move = function(self, playerX, playerY)
            dX, dY = playerX - self.x, playerY - self.y
            self.x = self.x + (1 / hypotenuse(dX, dY)) * dX * self.level
            self.y = self.y + (1 / hypotenuse(dX, dY)) * dY * self.level
        end,

        draw = function(self)
            love.graphics.setColor(1, 0.5, 0.7)
            love.graphics.circle("fill", self.x, self.y, self.radius)
            love.graphics.setColor(1, 1, 1)
        end
    }
end

function hypotenuse(x, y)
    return math.sqrt(x^2+y^2)
end

return Enemy