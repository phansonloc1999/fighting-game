---@class PlayerIdleState
PlayerIdleState = Class {__includes = BaseState}

PLAYER_MOVE_SPEED = 100

function PlayerIdleState:init(player)
    self.player = player ---@type Player
end

function PlayerIdleState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    self.player.currentAnimation = {
        anim = self.player.animations.idle.anim:clone(),
        image = self.player.animations.idle.image
    }
    if (self.player.isFacing ~= self.player.animations.idle.defaultFacing) then
        self.player.currentAnimation.anim = self.player.currentAnimation.anim:flipH()
    end
end

function PlayerIdleState:exit()
    self.player.hurtBoxes = {}
end

function PlayerIdleState:draw()
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
        self.player.currentAnimation.anim:draw(self.player.currentAnimation.image, self.player.x, self.player.y)
    end
end

function PlayerIdleState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)
    end

    if (love.keyboard.wasPressed(self.player.keyConfigs.attack)) then
        self.player.stateMachine:change("attack")
        return
    end

    if (love.keyboard.isDown(self.player.keyConfigs.left)) then
        self.player.isFacing = "left"
        self.player.stateMachine:change("move")
    elseif love.keyboard.isDown(self.player.keyConfigs.right) then
        self.player.isFacing = "right"
        self.player.stateMachine:change("move")
    end
end
