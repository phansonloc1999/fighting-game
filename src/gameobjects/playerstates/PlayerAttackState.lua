---@class PlayerAttackState
PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player)
    self.player = player ---@type Player
end

function PlayerAttackState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    self.player.currentMove = AttackMove(1, 1, 1, { CollisionBox(self.player.x + 30, self.player.y + 30, 60, 20) })
end

function PlayerAttackState:exit()
    self.player.hurtBoxes = {}
    self.player.hitBoxes = {}
end

function PlayerAttackState:draw()
    self.player.currentMove:draw()
end

function PlayerAttackState:update(dt)
    if (self.player.currentMove:isFinished()) then
        self.player.stateMachine:change("idle")
        return
    end

    self.player.currentMove:update(dt)
end