-- package.cpath = package.cpath .. ";c:/Users/Administrator/.vscode/extensions/tangzx.emmylua-0.3.28/debugger/emmy/windows/x64/?.dll"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require("src/Dependencies")
require("src/Assets")

---- Game states
Menu = require 'src.gamestates.Menu'
Game = require 'src.gamestates.Game'

function love.load()
    Gamestate.switch(Menu)
    Gamestate.registerEvents()
end

function love.update(dt)
end