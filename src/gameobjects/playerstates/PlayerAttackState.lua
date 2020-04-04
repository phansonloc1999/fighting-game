---@class PlayerAttackState
PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player)
    self.player = player ---@type Player
end

function PlayerAttackState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    if (self.player.isFacing == "right") then
        self.player.currentMove = AttackMove(20, 1, 1, 
                { CollisionBox(self.player.x + 42, self.player.y + 60, 40, 10) })
    else
        self.player.currentMove = AttackMove(20, 1, 1,
                { CollisionBox(self.player.x - 32, self.player.y + 60, 40, 10) })
    end

    self.player.currentAnimation = {
        anim = self.player.animations.stab.anim:clone(),
        image = self.player.animations.stab.image
    }
    if (self.player.isFacing ~= self.player.animations.stab.defaultFacing) then
        self.player.currentAnimation.anim = self.player.currentAnimation.anim:flipH()
    end
end

function PlayerAttackState:exit()
    self.player.hurtBoxes = {}
    self.player.hitBoxes = {}
    self.player.currentMove = nil
end

function PlayerAttackState:draw()
    self.player.currentAnimation.anim:draw(
		    self.player.currentAnimation.image,
		    self.player.x + self.player.hurtBoxes[1].width/2,
		    self.player.y + self.player.hurtBoxes[1].height/2,
		    0, 1, 1,
		    self.player.currentAnimation.image:getWidth()/3 /2,
		    self.player.currentAnimation.image:getHeight()/2 +2
    )
end

function PlayerAttackState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)
    end

    if (self.player.currentMove:isFinished()) then
        self.player.stateMachine:change("idle")
        return
    end

    self.player.currentMove:update(dt)
end