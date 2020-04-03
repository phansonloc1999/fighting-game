-- package.cpath = package.cpath .. ";c:/Users/Administrator/.vscode/extensions/tangzx.emmylua-0.3.28/debugger/emmy/windows/x64/?.dll"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require("src/Dependencies")
require("src/Assets")

function love.load()
    player = Player(50, 50)
end

function love.draw()
    player:draw()
end

function love.update(dt)
    --- require("libs/lovebird").update()
    player:update(dt)

    love.keyboard.keysPressed = {}
end