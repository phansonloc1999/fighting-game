---@class Player
Player = Class {}

function Player:init(x, y)
    self.x, self.y = x, y
    self.health = 100
    self.hurtBoxes = {} ---@type CollisionBox[]

    self.stateMachine =
        StateMachine {
        ["idle"] = function()
            return PlayerIdleState(self)
        end
    }

    self.stateMachine:change("idle")
end

function Player:draw()
    if (DEBUG_COLLISION_BOXES) then
        love.graphics.setColor(0, 1, 0)
        love.graphics.setLineWidth(3)
        for i = 1, #self.hurtBoxes do
            self.hurtBoxes[i]:draw()
        end
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(1)
    end

    self.stateMachine:draw()
end

function Player:update(dt)
    self.stateMachine:update(dt)
end
