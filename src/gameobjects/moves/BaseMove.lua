---@class BaseMove
BaseMove = Class {}

function BaseMove:init(startUp, recovery)
    self.startUp = startUp or 0
    self.recovery = recovery or 0
    self.elapsedFrames = 0
end

function BaseMove:draw()
end

function BaseMove:update(dt)
    self.elapsedFrames = self.elapsedFrames + 1
end