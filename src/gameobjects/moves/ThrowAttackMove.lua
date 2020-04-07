---@class ThrowAttackMove : AttackMove
ThrowAttackMove = Class {__includes = AttackMove}

function ThrowAttackMove:init(startUp, active, recovery, hitAdvantage, hitboxes, damage, isFacing)
    AttackMove.init(self, startUp, active, recovery, hitAdvantage, hitboxes, damage)

    local awayXOffset, backXOffset
    if (isFacing == "left") then
        awayXOffset, backXOffset = -100, 88
    else
        awayXOffset, backXOffset = 100, -88
    end
    Game.timer:after(
        0.2,
        function()
            Game.timer:tween(
                0.25,
                self.hitboxes[1],
                {x = self.hitboxes[1].x + awayXOffset},
                "linear",
                function()
                    Game.timer:tween(0.25, self.hitboxes[1], {x = self.hitboxes[1].x + backXOffset}, "linear")
                end
            )
        end
    )
end

function ThrowAttackMove:draw()
    AttackMove.draw(self)

    love.graphics.draw(Sprites.swordShield.shield, self.hitboxes[1].x, self.hitboxes[1].y)
end

function ThrowAttackMove:update(dt)
    AttackMove.update(self, dt)
end
