---@class Player
Player = Class {}

function Player:init(x, y, keyConfigs, animations, isFacing)
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
        end,
        ["block"] = function()
            return PlayerBlockState(self)
        end
    }

    self.keyConfigs = keyConfigs

    self.isFacing = isFacing

    self.animations = animations

    self.isBlocking = false

    self.stateMachine:change("idle")
end

function Player:draw()
    self.stateMachine:draw()
end

function Player:update(dt)
    self.stateMachine:update(dt)
end

function Player:takeDamage(ammount)
    self.health = self.health - ammount
end