local love = require "love"
local ballFunction = require "Ball"
local button = require "Button"
math.randomseed(os.time())

local game = {
    state = {menu = true,
        paused = false,
        running = false, 
        ended = false,
    }
}

local ball = {
    x = 300,
    y = 300,
    movement = math.random(-45, 45) * math.pi / 180
}

local player = 2

local leftBlock = {
    x = 60,
    y = 300
}

local rightBlock = {
    x = 520,
    y = 300
}

local blocks = {
    height = 70,
    width = 10
}

local buttons  = {
    menuState = {},
    pausedState = {},
    endedState = {}
}

local function changeGameState(state)
    game.state["menu"] = state == "menu"
    game.state["paused"] = state == "paused"
    game.state["running"] = state == "running"
    game.state["ended"] = state == "ended"
end

local function startNewGame()
    changeGameState("running")
    game.points = 0
    ball.x, ball.y, ball.movement = 300, 300, math.pi*0.4
    leftBlock.x, leftBlock.y = 60, 300
    rightBlock.x, rightBlock.y = 500, 300
    player = 2
end

function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menuState) do
                    buttons.menuState[index]:checkPressed(x, y, 10)
                end
            elseif game.state["ended"] then
                for index in pairs(buttons.endedState) do
                    buttons.endedState[index]:checkPressed(x, y, 10)
                end
            end
        end
    end
end

function love.load()
    love.mouse.setVisible(false)

    buttons.menuState.playGame = button("Play Game", startNewGame, nil, 20, 20, 120, 40, 5, 5)
    buttons.menuState.exitGame = button("Exit Game", love.event.quit, nil, 20, 80, 120, 40, 5, 5)
    
    buttons.endedState.replayGame = button("Replay", startNewGame, nil, 250, 200, 100, 50, 5, 5)
    buttons.endedState.menu = button("Menu", changeGameState, "menu", 250, 280, 100, 50, 5, 5)
    buttons.endedState.quit = button("Quit", love.event.quit, nil, 250, 360, 100, 50, 5, 5)
end

function love.update(dt)
    BALL = ballFunction(ball.x, ball.y, ball.movement, 20)
    if game.state["running"] then
        if player == 1 then
            if love.keyboard.isDown("w") then
                if leftBlock.y >= 0 then leftBlock.y, playerMovement = leftBlock.y - 4, math.pi / 30 end
            elseif love.keyboard.isDown("s") then
                if leftBlock.y <= love.graphics.getHeight() - blocks.height then leftBlock.y, playerMovement = leftBlock.y + 4, -math.pi / 30 end
            else playerMovement = 0 end
        elseif player == 2 then
            if love.keyboard.isDown("w") then
                if rightBlock.y >= 0 then rightBlock.y, playerMovement = rightBlock.y - 4, math.pi / 30 end
            elseif love.keyboard.isDown("s") then
                if rightBlock.y <= love.graphics.getHeight() - blocks.height then rightBlock.y, playerMovement = rightBlock.y + 4, -math.pi / 30 end
            else playerMovement = 0 end
        end
        
        if BALL:checkOut() then changeGameState("ended") end
        if BALL:checkCollision(leftBlock.x, leftBlock.y, blocks.width, blocks.height) then 
            if ball.x <= leftBlock.x + 30 and ball.x >= leftBlock.x + 29 then
                ball.movement, player = math.pi * 3 - ball.movement - playerMovement, 3 - player
            else 
                ball.movement, player = ball.movement + math.pi, 3 - player
            end
        end
        if BALL:checkCollision(rightBlock.x, rightBlock.y, blocks.width, blocks.height) then 
            if ball.x <= rightBlock.x - 9 and ball.x >= rightBlock.x - 10 then
                ball.movement, player = math.pi * 3 - ball.movement + playerMovement, 3 - player
            else
                ball.movement, player = ball.movement + math.pi, 3 - player
            end
        end
        if BALL:wallBounce() ~= 0 then ball.movement = BALL:wallBounce() end
        ball.x = ball.x + 5 * math.cos(ball.movement)
        ball.y = ball.y + 5 * math.sin(ball.movement)
    end
end

function love.draw()
    if game.state["running"] then

        love.graphics.setColor(0.85, 0.85, 0.85)
        if player == 1 then love.graphics.setColor(1, 1, 1) end
        love.graphics.rectangle("fill", leftBlock.x, leftBlock.y, blocks.width, blocks.height)

        love.graphics.setColor(0.85, 0.85, 0.85)
        if player == 2 then love.graphics.setColor(1, 1, 1) end
        love.graphics.rectangle("fill", rightBlock.x, rightBlock.y, blocks.width, blocks.height)
        BALL:draw()
    elseif game.state["menu"] then
        buttons.menuState.playGame:draw()
        buttons.menuState.exitGame:draw()
    elseif game.state["ended"] then
        buttons.endedState.replayGame:draw()
        buttons.endedState.menu:draw()
        buttons.endedState.quit:draw()
    end
    if not game.state["running"] then
        mouseX, mouseY = love.mouse.getPosition()
        love.graphics.circle("fill", mouseX, mouseY, 10)
    end
end
    