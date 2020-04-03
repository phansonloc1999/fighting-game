---@class Player
Player = Class {}

function Player:init(x, y, keyConfigs)
    self.x, self.y = x, y
    self.health = 100
    self.hurtBoxes = {} ---@type CollisionBox[]
    self.hitBoxes = {} ---@type CollisionBox[]
    self.currentMove = nil

    self.stateMachine =
        StateMachine {
        ["idle"] = function()
            return PlayerIdleState(self)
        end,
        ["move"] = function()
            return PlayerMoveState(self)
        end,
        ["attack"] = function()
            return PlayerAttackState(self)
        end
    }

    self.stateMachine:change("idle")

    self.keyConfigs = keyConfigs
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

    love.graphics.rectangle("fill", self.x, self.y, 50, 100)

    self.stateMachine:draw()
end

function Player:update(dt)
    self.stateMachine:update(dt)
end
