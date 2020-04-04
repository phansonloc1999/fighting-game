---@class AttackMove : BaseMove
AttackMove = Class {__includes = BaseMove}

function AttackMove:init(startUp, recovery, hitAdvantage, hitboxes, damage)
    BaseMove.init(self, startUp, recovery)

    self.hitAdvantage = hitAdvantage or 1
    self.hitboxes = hitboxes or {} ---@type CollisionBox[]

    assert(damage)
    self.damage = damage
end

function AttackMove:draw()
    if (DEBUG_COLLISION_BOXES) then
        love.graphics.setColor(1, 0, 0)
        love.graphics.setLineWidth(3)
        for i = 1, #self.hitboxes do
            self.hitboxes[i]:draw()
        end
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(1)
    end
end

function AttackMove:update(dt)
    BaseMove.update(self, dt)
end

function AttackMove:isFinished()
    return self.elapsedFrames > self.startUp + self.recovery
end
