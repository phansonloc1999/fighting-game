local Game = {}

function Game:enter(from, leftInfo, rightInfo)
    love.keyboard.keysPressed = {}

    self._info = {
        left = leftInfo,
        right = rightInfo
    }
    
    -- Init players
    player1 =
        Player(
        leftInfo.id,
        60,
        170,
        {left = "a", right = "d", attack = "c", block = "v", attack1 = "f"},
        {
            idle = Animations[leftInfo.id].idle,
            walk = Animations[leftInfo.id].walk,
            attack = Animations[leftInfo.id].attack,
            block = Animations[leftInfo.id].block,
            hit = Animations[leftInfo.id].hit,
            attack1 = Animations[leftInfo.id].attack1
        },
        "right",
        1
    )
    player2 =
        Player(
        rightInfo.id,
        436,
        170,
        {left = "left", right = "right", attack = "/", block = ".", attack1 = ";"},
        {
            idle = Animations[rightInfo.id].idle,
            walk = Animations[rightInfo.id].walk,
            attack = Animations[rightInfo.id].attack,
            block = Animations[rightInfo.id].block,
            hit = Animations[rightInfo.id].hit,
            attack1 = Animations[rightInfo.id].attack1
        },
        "left",
        2
    )

    healthbar = Healthbar(player1, player2, "health")

    self.timer = Timer.new()
end

function Game:draw()
    self:drawBackground()

    player1:draw()
    player2:draw()

    -- Render hitboxes first
    if (player1.currentMove) then
        player1.currentMove:draw()
    end
    if (player2.currentMove) then
        player2.currentMove:draw()
    end

    self:drawForeground()

    healthbar:draw()

    love.graphics.setFont(Fonts.large)
    love.graphics.setColor(0, 1, 1)
    love.graphics.print("P1", 18, 40)
    love.graphics.setColor(1, 1, 0)
    love.graphics.print("P2", 492, 40)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(Fonts.small)
    love.graphics.print("FPS: " .. love.timer.getFPS())
end

function Game:update(dt)
    -- require("libs/lovebird").update()

    if dt < 1 / (FPS_LIMIT / 2) then
        love.timer.sleep(1 / (FPS_LIMIT / 2) - dt)
    end

    if (dt < 1) then
        self.timer:update(dt)
        player1:update(dt)
        player2:update(dt)
        healthbar:update(dt)
    end

    if (not player1.isHit and not player2.isHit) then
        if player1.health <= 0 then
            self:toGameOver(1)
        elseif player2.health <= 0 then
            self:toGameOver(2)
        end
    end

    if (love.keyboard.wasPressed("`")) then
        DEBUG_COLLISION_BOXES = not DEBUG_COLLISION_BOXES
    end

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

function Game:drawBackground()
    local lg = love.graphics

    lg.setColor(1, 1, 1, 0.15)
    lg.setLineWidth(2)
    lg.line(0, 180, 560, 180)
    lg.setColor(1, 1, 1)

    lg.draw(Sprites.environment.tree1, 110, 115)
    lg.draw(Sprites.environment.tree2, 300, 105)

    lg.draw(Sprites.environment.twig2, 240, 206)
    lg.draw(Sprites.environment.twig1, 428, 188)

    lg.setColor(1, 1, 1, 0.4)
    lg.setLineWidth(2)
    lg.line(0, 235, 560, 235)
    lg.setColor(1, 1, 1)

    lg.draw(Sprites.environment.bush1, 260, 225)
end

function Game:drawForeground()
    local lg = love.graphics

    lg.setColor(1, 1, 1)
    lg.draw(Sprites.environment.bush2, 40, 274)
    lg.draw(Sprites.environment.bush3, 345, 264)
end

function Game:toGameOver(index)
    self.timer:after(
        0.06,
        function()
            local left = Gamestate.current()._info.left
            local right = Gamestate.current()._info.right
            Gamestate.switch(GameOver, left, right, index)
        end
    )
end

return Game
