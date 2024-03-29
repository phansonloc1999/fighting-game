---@class PlayerHitState
PlayerHitState = Class{__includes = BaseState}

function PlayerHitState:init(player)
    self.player = player
    self.otherPlayer = player == player1 and player2 or player1
end

function PlayerHitState:draw()
    if (DEBUG_COLLISION_BOXES) then
        love.graphics.setColor(0, 1, 0)
        love.graphics.setLineWidth(3)
        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:draw()
        end
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(1)
    end

    if (self.player.currentAnimation) then
		    self.player.currentAnimation.anim:draw(
						self.player.currentAnimation.image,
						self.player.x + self.player.hurtBoxes[1].width / 2,
						self.player.y + self.player.hurtBoxes[1].height -
								self.player.currentAnimation.image:getHeight(),
						0,
						1,
						1,
						self.player.currentAnimation.image:getWidth() / 2,
						nil
				)
    end
end

function PlayerHitState:enter(params)
    self.player.isHit = true

    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    self.player.currentAnimation = {
        anim = self.player.animations.hit.anim:clone(),
        image = self.player.animations.hit.image
    }
    
    if self.otherPlayer.isFacing == 'left' then
		    self.player.currentAnimation.anim:flipH()
    end
    
    self.player.isFacing = self.otherPlayer.isFacing == "left" and "right" or "left"
end

function PlayerHitState:exit()
    self.player.hurtBoxes = {}
    self.player.isHit = false
end

function PlayerHitState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)

        --- If player's hit animation is finished, change state to idle
        if self.player.currentAnimation.anim.timer >= self.player.currentAnimation.anim.totalDuration - 0.03 then
            self.player.stateMachine:change("idle")
        end
    end
end