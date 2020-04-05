---@class BlockMove
BlockMove = Class{}

function BlockMove:init()
    BaseMove.init(self, 1, 1)
end

function BlockMove:draw()
end

function BlockMove:update(dt)
    BaseMove.update(self, dt)
end