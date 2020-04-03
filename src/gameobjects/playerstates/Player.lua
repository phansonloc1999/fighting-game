---@class Player
Player = Class{}

function Player:init(x, y)
    self.x, self.y = x, y
    self.health = 100

    self.stateMachine = StateMachine{
        ["idle"] = function() return PlayerIdleState(self) end
    }
    
    self.stateMachine:change("idle")
end

function Player:draw()
    self.stateMachine:draw()
end

function Player:update(dt)
    self.stateMachine:update(dt)
end