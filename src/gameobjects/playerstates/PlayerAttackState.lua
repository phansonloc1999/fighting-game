---@class PlayerAttackState
PlayerAttackState = Class {__includes = BaseState}

function PlayerAttackState:init(player)
    self.player = player ---@type Player
    self.otherPlayer = player == player1 and player2 or player1
    self.checkOnce = false
end

function PlayerAttackState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    if (self.player.isFacing == "right") then
        self.player.currentMove =
            AttackMove(3, 60, 1, {CollisionBox(self.player.x + 42, self.player.y + 60, 40, 10)}, 10)
    else
        self.player.currentMove =
            AttackMove(3, 60, 1, {CollisionBox(self.player.x - 32, self.player.y + 60, 40, 10)}, 10)
    end

    self.player.currentAnimation = {
        anim = self.player.animations.stab.anim:clone(),
        image = self.player.animations.stab.image
    }
    if (self.player.isFacing ~= self.player.animations.stab.defaultFacing) then
        self.player.currentAnimation.anim = self.player.currentAnimation.anim:flipH()
    end

    self.checkOnce = false
end

function PlayerAttackState:exit()
    self.player.hurtBoxes = {}
    self.player.hitBoxes = {}
    self.player.currentMove = nil
end

function PlayerAttackState:draw()
		self.player.currentAnimation.anim:draw(
        self.player.currentAnimation.image,
        self.player.x + self.player.hurtBoxes[1].width / 2,
        self.player.y + self.player.hurtBoxes[1].height -
						self.player.currentAnimation.image:getHeight(),
        0,
        1,
        1,
        self.player.currentAnimation.image:getWidth() / 3 / 2,
        nil
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

    if (self.player.currentMove.elapsedFrames > self.player.currentMove.startUp) then
        self:checkHitOtherPlayer()
    end
end

function PlayerAttackState:checkHitOtherPlayer()
    --- Check whether attack is blocked or not by other player one time per attack
    --- If is not, damage player and skip checking until exit this state
    if not self.checkOnce then
        for i = 1, #self.player.currentMove.hitboxes do
            for j = 1, #self.otherPlayer.hurtBoxes do
                if (self.player.currentMove.hitboxes[i]:collidesWith(self.otherPlayer.hurtBoxes[j])) then
                    if
                        (self.otherPlayer.isBlocking and self.player.isFacing == self.otherPlayer.isFacing) or
                            not self.otherPlayer.isBlocking
                     then
                        self.otherPlayer:takeDamage(self.player.currentMove.damage)
                        self.checkOnce = true

                        self.otherPlayer.stateMachine:change("hit")
                        return
                    elseif (self.otherPlayer.isBlocking and self.player.isFacing ~= self.otherPlayer.isFacing) then
                        self.checkOnce = true
                        return
                    end
                end
            end
        end
    end
end
