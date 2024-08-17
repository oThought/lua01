local love = require "love"
local enemy = require "Enemy"
local button = require "Button"

math.randomseed(os.time())

local game = {
    difficulty = 1,
    state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    },
    points = 0,
    levels = {15, 30, 60, 120}
}

local fonts = {
    medium = {
        font = love.graphics.newFont(16),
        size = 16
    },
    large = {
        font = love.graphics.newFont(24),
        size = 24
    },
    massive = {
        font = love.graphics.newFont(60),
        size = 60
    }
}

local player = {
    radius = 20,
    x = 30, 
    y = 30
}

local buttons = {
    menuState = {},
    endedState = {}
}

local enemies = {}

local function changeGameState(state)
    game.state["menu"] = state == "menu"
    game.state["paused"] = state == "paused"
    game.state["running"] = state == "running"
    game.state["ended"] = state == "ended"
end

local function startNewGame()
    changeGameState("running")
    game.points = 0
    enemies = {enemy(1)}
end

function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menuState) do
                    buttons.menuState[index]:checkPressed(x, y, player.radius)
                end
            elseif game.state["ended"] then
                for index in pairs(buttons.endedState) do
                    buttons.endedState[index]:checkPressed(x, y, player.radius)
                end
            end
        end
    end
end

function love.load()
    love.mouse.setVisible(false)

    buttons.menuState.playGame = button("Play Game", startNewGame, nil, 120, 40)
    buttons.menuState.settings = button("Settings", nil, nil, 120, 40)
    buttons.menuState.exitGame = button("Exit Game", love.event.quit, nil, 120, 40)

    buttons.endedState.replayGame = button("Replay", startNewGame, nil, 100, 50)
    buttons.endedState.menu = button("Menu", changeGameState, "menu", 100, 50)
    buttons.endedState.exitGame = button("Quit", love.event.quit, nil, 100, 50)
end

function love.update(dt)
    player.x, player.y = love.mouse.getPosition()
    if game.state["running"] then
        for i = 1, #enemies do
            if not enemies[i]:checkTouched(player.x, player.y, player.radius) then
                enemies[i]:move(player.x, player.y)
                for i = 1, #game.levels do
                    if math.floor(game.points) == game.levels[i] then
                        table.insert(enemies, 1, enemy(game.difficulty * (i+1)))
                        game.points = game.points + 1
                    end
                end
            else
                changeGameState("ended")
            end
        end
        game.points = game.points + dt
    end
end

function love.draw()
    love.graphics.setFont(fonts.medium.font)
    love.graphics.print("FPS: " .. love.timer.getFPS(), fonts.medium.font, 10, 10)
    if game.state["running"] then
        love.graphics.print("Score: " .. math.floor(game.points), fonts.medium.font, 100, 10)
        for i = 1, #enemies do
            enemies[i]:draw()
        end
        love.graphics.circle("fill", player.x, player.y, player.radius)
    elseif game.state["menu"] then
        buttons.menuState.playGame:draw(10, 40, 17, 10)
        buttons.menuState.settings:draw(10, 90, 17, 10)
        buttons.menuState.exitGame:draw(10, 140, 17, 10)
    elseif game.state["ended"] then
        love.graphics.setFont(fonts.large.font)
        buttons.endedState.replayGame:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.8, 10, 10)
        buttons.endedState.menu:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.54, 17, 10)
        buttons.endedState.exitGame:draw(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.33 , 22, 10)
        love.graphics.printf(math.floor(game.points), fonts.massive.font, 0, love.graphics.getHeight() / 2 - fonts.massive.size, love.graphics.getWidth(), "center")
    end
    if not game.state["running"] then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
end