---@class PlayerMoveState
PlayerMoveState = Class {__includes = BaseState}

function PlayerMoveState:init(player)
    self.player = player ---@type Player
end

function PlayerMoveState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    self.player.currentAnimation = {
        anim = self.player.animations.walk.anim:clone(),
        image = self.player.animations.walk.image
    }

    if (self.player.isFacing ~= self.player.animations.walk.defaultFacing) then
        self.player.currentAnimation.anim = self.player.currentAnimation.anim:flipH()
    end
end

function PlayerMoveState:exit()
    self.player.hurtBoxes = {}
end

function PlayerMoveState:draw()
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
						self.player.currentAnimation.image:getWidth() / 4 / 2,
						nil
				)
    end
end

function PlayerMoveState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)
    end

    if (love.keyboard.wasPressed(self.player.keyConfigs.attack)) then
        self.player.stateMachine:change("attack", { moveData = self.player.moveData.attack, attackKeyConf = "attack" })
        return
    end
    if (love.keyboard.wasPressed(self.player.keyConfigs.attack1)) then
        self.player.stateMachine:change("attack", {attackKeyConf = "attack1", moveData = self.player.moveData.attack1})
        return
    end

    if (love.keyboard.isDown(self.player.keyConfigs.left)) then
        self.player.x = self.player.x - self.player.speed * dt

        --- update hurtboxes positions
        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:offsetPos(-self.player.speed * dt, 0)
        end
    elseif (love.keyboard.isDown(self.player.keyConfigs.right)) then
        self.player.x = self.player.x + self.player.speed * dt

        --- update hurtboxes positions
        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:offsetPos(self.player.speed * dt, 0)
        end
    end

    if
        (love.keyboard.wasReleased(self.player.keyConfigs.left) or
            love.keyboard.wasReleased(self.player.keyConfigs.right))
     then
        self.player.stateMachine:change("idle")
        return
    end

    if (love.keyboard.wasPressed(self.player.keyConfigs.block)) then
        self.player.stateMachine:change("block")
    end
end
