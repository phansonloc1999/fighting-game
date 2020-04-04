package.cpath = package.cpath .. ";c:/Users/Administrator/.vscode/extensions/tangzx.emmylua-0.3.28/debugger/emmy/windows/x64/?.dll"
local dbg = require("emmy_core")
dbg.tcpListen("localhost", 9966)

require("src/Dependencies")
require("src/Assets")

function love.load()
    Tick.framerate = FPS_LIMIT

    player1 =
        Player(
        50,
        50,
        {left = "left", right = "right", attack = "j", block = "k"},
        {idle = Animations.daggers.idle, walk = Animations.daggers.walk, stab = Animations.daggers.stab, block = Animations.daggers.block},
        "right"
    )
    player2 =
        Player(
        250,
        50,
        {left = "a", right = "d", attack = "f", block = "g"},
        {idle = Animations.daggers.idle, walk = Animations.daggers.walk, stab = Animations.daggers.stab, block = Animations.daggers.block},
        "left"
    )

		healthbar = Healthbar(player1, player2, 'health')

    anim = Animations.daggers.stab
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

		healthbar:draw()

    love.graphics.print("FPS: " .. love.timer.getFPS())
end

function love.update(dt)
    -- require("libs/lovebird").update()

    if (dt < 1) then
        player1:update(dt)
        player2:update(dt)
        healthbar:update(dt)
    end

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end
