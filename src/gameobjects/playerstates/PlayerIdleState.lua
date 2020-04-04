---@class PlayerIdleState
PlayerIdleState = Class {__includes = BaseState}

PLAYER_MOVE_SPEED = 100

function PlayerIdleState:init(player)
    self.player = player ---@type Player
end

function PlayerIdleState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))
end

function PlayerIdleState:exit()
    self.player.hurtBoxes = {}
end

function PlayerIdleState:draw()
end

function PlayerIdleState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)
    end

    if (love.keyboard.wasPressed(self.player.keyConfigs.attack)) then
        self.player.stateMachine:change("attack")
        return
    end

    if (love.keyboard.wasPressed(self.player.keyConfigs.left) or love.keyboard.wasPressed(self.player.keyConfigs.right)) then
        self.player.stateMachine:change("move")
    end
end
