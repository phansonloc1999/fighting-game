local Game = {}

function Game:enter(from, leftInfo, rightInfo)
    Tick.framerate = FPS_LIMIT
    Tick.rate = 0.03

    -- Init players
    player1 =
        Player(
        50,
        100,
        {left = "left", right = "right", attack = "j", block = "k"},
        {
            idle = Animations[rightInfo.id].idle,
            walk = Animations[rightInfo.id].walk,
            stab = Animations[rightInfo.id].stab,
            block = Animations[rightInfo.id].block,
            hit = Animations[rightInfo.id].hit
        },
        "right"
    )
    player2 =
        Player(
        250,
        100,
        {left = "a", right = "d", attack = "f", block = "g"},
        {
            idle = Animations[leftInfo.id].idle,
            walk = Animations[leftInfo.id].walk,
            stab = Animations[leftInfo.id].stab,
            block = Animations[leftInfo.id].block,
            hit = Animations[leftInfo.id].hit
        },
        "left"
    )

    healthbar = Healthbar(player1, player2, "health")

    anim = Animations.daggers.stab
end

function Game:draw()
    player1:draw()
    player2:draw()

    -- Render hitboxes first
    if (player1.currentMove) then
        player1.currentMove:draw()
    end
    if (player2.currentMove) then
        player2.currentMove:draw()
    end

    healthbar:draw()

    love.graphics.print("FPS: " .. love.timer.getFPS())
end

function Game:update(dt)
    if (dt < 1) then
        player1:update(dt)
        player2:update(dt)
        healthbar:update(dt)
    end

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

return Game