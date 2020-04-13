---@class PlayerAttackState
PlayerAttackState = Class {__includes = BaseState}

function PlayerAttackState:init(player)
    self.player = player ---@type Player
    self.otherPlayer = player == player1 and player2 or player1
    self.checkedOnce = false
end

function PlayerAttackState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    if (self.player.charId == "swordShield" and params.attackKeyConf == "attack1") then
        self.player.currentMove =
            self:getThrowAttackMove(
            params.moveData.frame,
            params.moveData.hitbox,
            params.moveData.damage,
            self.player.isFacing
        )
    else
        self.player.currentMove =
            self:getAttackMove(
            params.moveData.frame,
            params.moveData.hitbox,
            params.moveData.damage,
            self.player.isFacing
        )
    end

    self:getAnimationByKeyConfig(params.attackKeyConf)
    if (self.player.isFacing ~= self.player.animations.attack.defaultFacing) then
        self.player.currentAnimation.anim = self.player.currentAnimation.anim:flipH()
    end

    self.checkedOnce = false
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
        self.player.y + self.player.hurtBoxes[1].height - self.player.currentAnimation.image:getHeight(),
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

    if (self.player.currentMove:isInActive()) then
        self:checkHitOtherPlayer()
    end
end

function PlayerAttackState:checkHitOtherPlayer()
    --- Check whether attack is blocked or not by other player one time per attack
    --- If is not, damage player and skip checking until exit this state
    if not self.checkedOnce then
        for i = 1, #self.player.currentMove.hitboxes do
            for j = 1, #self.otherPlayer.hurtBoxes do
                if (self.player.currentMove.hitboxes[i]:collidesWith(self.otherPlayer.hurtBoxes[j])) then
                    if self:attackIsNotBlocked() then
                        self.otherPlayer:takeDamage(self.player.currentMove.damage)
                        self.otherPlayer.stateMachine:change("hit")

                        self.checkedOnce = true
                        return
                    elseif (self:attackIsBlocked()) then
                        local reducedDamageTaken = self.player.currentMove.damage / 100 * 15
                        self.otherPlayer:takeDamage(reducedDamageTaken)
                        self.checkedOnce = true
                        return
                    end
                end
            end
        end
    end
end

function PlayerAttackState:attackIsNotBlocked()
    return (self.otherPlayer.isBlocking and self.player.isFacing == self.otherPlayer.isFacing) or
        not self.otherPlayer.isBlocking
end

function PlayerAttackState:attackIsBlocked()
    return self.otherPlayer.isBlocking and self.player.isFacing ~= self.otherPlayer.isFacing
end

function PlayerAttackState:getAttackMove(frameData, hitbox, damage, isFacing)
    return AttackMove(
        frameData.startUp,
        frameData.active,
        frameData.recovery,
        0,
        {
            CollisionBox(
                self.player.x + hitbox[isFacing].x,
                self.player.y + hitbox[isFacing].y,
                hitbox[isFacing].w,
                hitbox[isFacing].h
            )
        },
        damage
    )
end

function PlayerAttackState:getThrowAttackMove(frameData, hitbox, damage, isFacing)
    return ThrowAttackMove(
        frameData.startUp,
        frameData.active,
        frameData.recovery,
        0,
        {
            CollisionBox(
                self.player.x + hitbox[isFacing].x,
                self.player.y + hitbox[isFacing].y,
                hitbox[isFacing].w,
                hitbox[isFacing].h
            )
        },
        damage,
        isFacing
    )
end

function PlayerAttackState:getAnimationByKeyConfig(attackKeyConf)
    local keyInAnimationsTable
    if (self.player.keyConfigs.attack == attackKeyConf) then
        keyInAnimationsTable = "attack"
    elseif (self.player.keyConfigs.attack1 == attackKeyConf) then
        keyInAnimationsTable = "attack1"
    end
    self.player.currentAnimation = {
        anim = self.player.animations[keyInAnimationsTable].anim:clone(),
        image = self.player.animations[keyInAnimationsTable].image
    }
end