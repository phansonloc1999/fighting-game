---@class PlayerIdleState
PlayerIdleState = Class{__includes = BaseState}

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
    love.graphics.rectangle("fill", self.player.x, self.player.y, 50, 100)
end

function PlayerIdleState:update(dt)
    if (love.keyboard.isDown("left")) then
        self.player.x = self.player.x - PLAYER_MOVE_SPEED * dt

        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:offsetPos(-PLAYER_MOVE_SPEED * dt, 0)
        end
    elseif (love.keyboard.isDown("right")) then
        self.player.x = self.player.x + PLAYER_MOVE_SPEED * dt
        
        for i = 1, #self.player.hurtBoxes do
            self.player.hurtBoxes[i]:offsetPos(PLAYER_MOVE_SPEED * dt, 0)
        end
    end
end