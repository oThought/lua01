_G.love = require("love")
    
function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 1)
    _G.pacman = {}
    pacman.x = 200
    pacman.y = 200
    pacman.angle1 = 5
    pacman.animation = math.pi / 400
    pacman.close = true
    G_pieces = {}
    pieces = {{{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}, 
              {{}, {}, {}, {}, {}, {}, {}, {}}}
    for i = 1, 8 do
        for j = 1, 8 do
            pieces[i][j][1] = 60*i
            pieces[i][j][2] = 60*j
        end
    end
    
end

function hypotenuse(x, y)
    return (x^2+y^2)^0.5
end

function eat(foodX, foodY)
    corners = {{foodX-5, foodY-5}, {foodX+5, foodY-5}, {foodX-5, foodY+5}, {foodX+5, foodY+5}}
    for i = 1, 4 do
        if hypotenuse(pacman.x - corners[i][1], pacman.y - corners[i][2]) <= 40 then return true end
    end
    return false
end

function love.update(dt)
    mouseX, mouseY = love.mouse.getPosition()
    dX, dY = mouseX - pacman.x, mouseY - pacman.y
    pacmanX, pacmanY = (1 / hypotenuse(dX, dY)) * dX, (1 / hypotenuse(dX, dY)) * dY
    if not (math.abs(dX) <= 1 and math.abs(dY) <= 1) then
        pacman.angle1 = math.atan2(dX, dY) * -1 + math.pi * 0.75
        pacman.x = pacman.x + pacmanX
        pacman.y = pacman.y + pacmanY
    end
    if close == true and pacman.animation <= math.pi / 4 then pacman.animation = pacman.animation + math.pi / 150 elseif close == false and pacman.animation >= 0.01 then pacman.animation = pacman.animation - math.pi / 150 else close = not close end
    --[[
    if love.keyboard.isDown("w") then
        pacman.y = pacman.y - 1
    elseif love.keyboard.isDown("a") then
        pacman.x = pacman.x - 1
    elseif love.keyboard.isDown("s") then
        pacman.y = pacman.y + 1
    elseif love.keyboard.isDown("d") then
        pacman.x = pacman.x + 1
    end
    ]]--
end

function love.draw()
    love.graphics.setColor(1, 0.7, 0.1)
    love.graphics.arc("fill", pacman.x, pacman.y, 40, pacman.angle1 - pacman.animation, pacman.angle1 + math.pi * 1.5 + pacman.animation)
    love.graphics.setColor(1, 1, 1)
    for i = 1, 8 do
        for j = 1, 8 do
            if eat(pieces[i][j][1], pieces[i][j][2]) then pieces[i][j][1], pieces[i][j][2] = 0, 0 end
            if not (pieces[i][j][1] == 0 and pieces[i][j][2] == 0) then
                love.graphics.rectangle("fill", pieces[i][j][1]-5, pieces[i][j][2]-5, 10, 10)
            end
        end
    end
end