---@class PlayerIdleState
PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player ---@type Player
end

function PlayerIdleState:enter(params)
    
end

function PlayerIdleState:exit()
end

function PlayerIdleState:draw()
    love.graphics.rectangle("fill", self.player.x, self.player.y, 50, 50)
end

function PlayerIdleState:update(dt)
end