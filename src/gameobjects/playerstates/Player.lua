---@class Player
Player = Class {}

function Player:init(charId, x, y, keyConfigs, animations, isFacing)
    self.x, self.y = x, y
    self.health = 100
    self.speed = CharacterStats[charId].speed
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
        end,
        ["hit"] = function()
            return PlayerHitState(self)
        end
    }

    self.keyConfigs = keyConfigs

    self.isFacing = isFacing

    self.animations = animations
    self.moveData = self:loadCharMoveData(charId)

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

function Player:loadCharMoveData(charId)
    for key, value in pairs(MoveData) do
        if (charId == key) then
            return MoveData[charId]
        end
    end
end