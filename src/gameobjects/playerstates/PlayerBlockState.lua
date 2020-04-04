---@class PlayerBlockState
PlayerBlockState = Class {__includes = BaseState}

function PlayerBlockState:init(player)
    self.player = player ---@type Player
    self.player.isBlocking = true
end

function PlayerBlockState:enter(params)
    table.insert(self.player.hurtBoxes, CollisionBox(self.player.x, self.player.y, 50, 100))

    self.player.currentMove = BlockMove(21, 10, 10)

    self.player.currentAnimation = {
        anim = self.player.animations.block.anim:clone(),
        image = self.player.animations.block.image
    }
    if (self.player.isFacing ~= self.player.animations.block.defaultFacing) then
        self.player.currentAnimation.anim = self.player.currentAnimation.anim:flipH()
    end
end

function PlayerBlockState:exit()
    self.player.currentMove = nil
    self.player.hurtBoxes = {}
    self.player.isBlocking = false
end

function PlayerBlockState:draw()
    self.player.currentAnimation.anim:draw(
        self.player.currentAnimation.image,
        self.player.x + self.player.hurtBoxes[1].width / 2,
        self.player.y + self.player.hurtBoxes[1].height / 2,
        0,
        1,
        1,
        self.player.currentAnimation.image:getWidth() / 2,
        self.player.currentAnimation.image:getHeight() / 2
    )
end

function PlayerBlockState:update(dt)
    if (self.player.currentAnimation) then
        self.player.currentAnimation.anim:update(dt)
    end

    self.player.currentMove:update(dt)

    if (self.player.currentMove:isFinished()) then
        self.player.stateMachine:change("idle")
        return
    end
end
