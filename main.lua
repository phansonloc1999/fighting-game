-- package.cpath = package.cpath .. ";c:/Users/Administrator/.vscode/extensions/tangzx.emmylua-0.3.28/debugger/emmy/windows/x64/?.dll"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require("src/Dependencies")
require("src/Assets")

function love.load()
    Tick.framerate = FPS_LIMIT

    player1 =
        Player(
        50,
        50,
        {left = "left", right = "right", attack = "j"},
        {idle = Animations.daggers.idle, walk = Animations.daggers.walk},
        "right"
    )
    player2 =
        Player(
        250,
        50,
        {left = "a", right = "d", attack = "f"},
        {idle = Animations.daggers.idle, walk = Animations.daggers.walk},
        "left"
    )
end

function love.draw()
    player1:draw()
    player2:draw()

    -- Render hitboxes first
    if (player1.currentMove) then
        player1.currentMove:draw()
    end
    if (player2.currentMove) then
        player2.currentMove:draw()
    end

    love.graphics.print("FPS: " .. love.timer.getFPS())
end

function love.update(dt)
    --- require("libs/lovebird").update()

    if (dt < 1) then
        player1:update(dt)
        player2:update(dt)
    end

    love.keyboard.keysPressed = {}
end
