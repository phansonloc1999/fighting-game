-- package.cpath = package.cpath .. ";c:/Users/Administrator/.vscode/extensions/tangzx.emmylua-0.3.28/debugger/emmy/windows/x64/?.dll"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require("src/Dependencies")

function love.load()

end

function love.draw()
    -- body
end

function love.update(dt)
    --- require("libs/lovebird").update()

    love.keyboard.keysPressed = {}
end