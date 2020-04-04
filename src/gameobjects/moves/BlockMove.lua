---@class BlockMove
BlockMove = Class{}

function BlockMove:init(startUp, recovery, blockAdvantage)
    BaseMove.init(startUp, recovery)
    
    self.blockAdvantage = blockAdvantage
end

function BlockMove:draw()
end

function BlockMove:update(dt)
    BaseMove.update(self, dt)
end

function BlockMove:isFinished()
    return self.elapsedFrames > self.startUp + self.recovery
end