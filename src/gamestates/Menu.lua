local Menu = {}

local previewAnimations = {
    left = {
        daggers = getAnimation(Sprites.daggers.idle, 2, 0.28),
        swordShield = getAnimation(Sprites.swordShield.idle, 2, 0.3),
        broadSword = getAnimation(Sprites.broadSword.idle, 2, 0.32)
    },
    right = {
        daggers = getAnimation(Sprites.daggers.idle, 2, 0.26),
        swordShield = getAnimation(Sprites.swordShield.idle, 2, 0.29),
        broadSword = getAnimation(Sprites.broadSword.idle, 2, 0.32)
    }
}
for _, animation in pairs(previewAnimations.left) do
    animation:flipH()
end

function Menu:enter()
    self.suit = Suit.new()
    self.suit.theme.color = {
        normal = {bg = {0, 0, 0}, fg = {1, 1, 1}},
        hovered = {bg = {0, 0, 0}, fg = {1, 1, 1}},
        active = {bg = {0, 0, 0}, fg = {1, 1, 1}}
    }

    self.timer = Timer.new()
    self.suitAnimation = {}
    for i = 0, 6 do
        self.suitAnimation[i] = {len = 0, timer = nil}
    end

    self.leftInfo = {id = "daggers", keybind = {}}
    self.rightInfo = {id = "daggers", keybind = {}}

    self.currentFrame = "main"
end

function Menu:update(dt)
	if dt < 1 / (FPS_LIMIT / 2) then
		love.timer.sleep(1 / (FPS_LIMIT / 2) - dt)
	end

    self.timer:update(dt)

    updatePreviewAnimation(dt)

    if self.currentFrame == "main" then
        self:mainMenu(dt)
    elseif self.currentFrame == "keybinding" then
        self:keyBind()
    end
end

function updatePreviewAnimation(dt)
    previewAnimations.left.daggers:update(dt)
    previewAnimations.left.swordShield:update(dt)
    previewAnimations.left.broadSword:update(dt)

    previewAnimations.right.daggers:update(dt)
    previewAnimations.right.swordShield:update(dt)
    previewAnimations.right.broadSword:update(dt)
end

function Menu:mainMenu(dt)
    -- Start button
    if self.suit:Button("BATTLE", {font = Fonts.medium, id = 0}, 222, 160, 100, 30).hovered then
        self.suitAnimation[0].len = self.suitAnimation[0].len + 400 * dt
        if self.suitAnimation[0].len > 80 then
            self.suitAnimation[0].len = 80
        end
    else
        self.suitAnimation[0].len = self.suitAnimation[0].len - 400 * dt
        if self.suitAnimation[0].len < 0 then
            self.suitAnimation[0].len = 0
        end
    end
    if self.suit:Button("BATTLE", {font = Fonts.medium, id = 0}, 222, 160, 100, 30).hit then
        Gamestate.switch(Game, self.leftInfo, self.rightInfo)
    end

    -- Character select buttons
    local id = {"daggers", "swordShield", "broadSword"}
    for i = 1, 3 do
        if self.suit:Button(id[i]:upper(), {font = Fonts.small, id = i}, 10, 40 * i, 120, 40).hovered then
            self.suitAnimation[i].len = self.suitAnimation[i].len + 600 * dt
            if self.suitAnimation[i].len > 120 then
                self.suitAnimation[i].len = 120
            end
        else
            self.suitAnimation[i].len = self.suitAnimation[i].len - 600 * dt
            if self.suitAnimation[i].len < 0 then
                self.suitAnimation[i].len = 0
            end
        end
        if self.suit:Button(id[i]:upper(), {font = Fonts.small, id = i}, 10, 40 * i, 120, 40).hit then
            self.leftInfo.id = id[i]
        end
    end
    for i = 1, 3 do
        if self.suit:Button(id[i]:upper(), {font = Fonts.small, id = i + 3}, 420, 40 * i, 120, 40).hovered then
            self.suitAnimation[i + 3].len = self.suitAnimation[i + 3].len + 1200 * dt
            if self.suitAnimation[i + 3].len > 120 then
                self.suitAnimation[i + 3].len = 120
            end
        else
            self.suitAnimation[i + 3].len = self.suitAnimation[i + 3].len - 600 * dt
            if self.suitAnimation[i + 3].len < 0 then
                self.suitAnimation[i + 3].len = 0
            end
        end
        if self.suit:Button(id[i]:upper(), {font = Fonts.small, id = i + 3}, 420, 40 * i, 120, 40).hit then
            self.rightInfo.id = id[i]
        end
    end
end

function Menu:draw()
    love.graphics.setColor(1, 1, 1)

    ---- Preview animation
    previewAnimations["left"][self.leftInfo.id]:draw(
        Sprites[self.leftInfo.id].idle,
        190,
        40,
        0,
        1,
        1,
        Sprites[self.leftInfo.id].idle:getWidth() / 2 / 2
    )
    previewAnimations["right"][self.rightInfo.id]:draw(
        Sprites[self.rightInfo.id].idle,
        350,
        40,
        0,
        1,
        1,
        Sprites[self.rightInfo.id].idle:getWidth() / 2 / 2
    )

    self.suit:draw()
    ---- Suit animation
    love.graphics.setLineWidth(2)
    love.graphics.line(
        230 + 80 / 2 - self.suitAnimation[0].len / 2,
        188,
        230 + 80 / 2 + self.suitAnimation[0].len / 2,
        188
    )
    for i = 1, 3 do
        love.graphics.line(
            10 + 100 / 2 - self.suitAnimation[i].len / 2,
            40 * i + 30,
            10 + 120 / 2 + self.suitAnimation[i].len / 2,
            40 * i + 30
        )
    end
    for i = 4, 6 do
        love.graphics.line(
            420 + 100 / 2 - self.suitAnimation[i].len / 2,
            40 * (i - 3) + 30,
            420 + 120 / 2 + self.suitAnimation[i].len / 2,
            40 * (i - 3) + 30
        )
    end

    love.graphics.setFont(Fonts.gigantic)
    love.graphics.setColor(1, 1, 0.3)
    love.graphics.printf("GLADIATORS", 540 / 2 - 200, 225, 400, "center")
end

return Menu
