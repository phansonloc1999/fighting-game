---@class PlayerIdleState
PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player ---@type Player
end

function PlayerIdleState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))
end

function PlayerIdleState:exit()
    self.player.hurtBoxes = {}
end

function PlayerIdleState:draw()
    love.graphics.rectangle("fill", self.player.x, self.player.y, 50, 100)
end

function PlayerIdleState:update(dt)
end