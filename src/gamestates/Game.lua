local Game = {}

function Game:enter(from, leftInfo, rightInfo)
    Tick.framerate = FPS_LIMIT
    Tick.rate = 0.03

    -- Init players
    player1 =
        Player(
        60,
        170,
        {left = "a", right = "d", attack = "f", block = "g"},
        {
            idle = Animations[leftInfo.id].idle,
            walk = Animations[leftInfo.id].walk,
            stab = Animations[leftInfo.id].stab,
            block = Animations[leftInfo.id].block,
            hit = Animations[leftInfo.id].hit
        },
        "right"
    )
    player2 =
        Player(
        436,
        170,
        {left = "left", right = "right", attack = "j", block = "k"},
        {
            idle = Animations[rightInfo.id].idle,
            walk = Animations[rightInfo.id].walk,
            stab = Animations[rightInfo.id].stab,
            block = Animations[rightInfo.id].block,
            hit = Animations[rightInfo.id].hit
        },
        "left"
    )

    healthbar = Healthbar(player1, player2, "health")

    anim = Animations.daggers.stab
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

return Game