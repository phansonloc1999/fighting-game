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
end

function PlayerMoveState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)
    end

    if (love.keyboard.wasPressed(self.player.keyConfigs.attack)) then
        self.player.stateMachine:change("attack")
        return
    end

    if (love.keyboard.isDown(self.player.keyConfigs.left)) then
        self.player.x = self.player.x - PLAYER_MOVE_SPEED * dt

        --- update hurtboxes positions
        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:offsetPos(-PLAYER_MOVE_SPEED * dt, 0)
        end
    elseif (love.keyboard.isDown(self.player.keyConfigs.right)) then
        self.player.x = self.player.x + PLAYER_MOVE_SPEED * dt

        --- update hurtboxes positions
        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:offsetPos(PLAYER_MOVE_SPEED * dt, 0)
        end
    end

    if
        (love.keyboard.wasReleased(self.player.keyConfigs.left) or
            love.keyboard.wasReleased(self.player.keyConfigs.right))
     then
        self.player.stateMachine:change("idle")
        return
    end
end
