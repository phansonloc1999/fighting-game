local Menu = {}

local previewAnimations = {
	left = {
		daggers = getAnimation(Sprites.daggers.idle, 2, 0.28),
		swordShield = getAnimation(Sprites.swordShield.idle, 2, 0.3),
		broadSword = getAnimation(Sprites.broadSword.idle, 2, 0.32),
	},
	right = {
		daggers = getAnimation(Sprites.daggers.idle, 2, 0.26),
		swordShield = getAnimation(Sprites.swordShield.idle, 2, 0.29),
		broadSword = getAnimation(Sprites.broadSword.idle, 2, 0.32),
	}
}
for _, animation in pairs(previewAnimations.left) do animation:flipH() end

function Menu:enter()
	Tick.framerate = -1
	Tick.rate = 0.006

	self.suit = Suit.new()
	
	self.leftInfo = {id = 'daggers', keybind = {}}
	self.rightInfo = {id = 'daggers', keybind = {}}
	
	self.currentFrame = 'main'
end

function Menu:update(dt)
	updateAnimation(dt)

	if self.currentFrame == 'main' then
		self:mainMenu(dt)
	elseif self.currentFrame == 'keybinding' then
		self:keyBind()
	end
end

function updateAnimation(dt)
	previewAnimations.left.daggers:update(dt)
	previewAnimations.left.swordShield:update(dt)
	previewAnimations.left.broadSword:update(dt)
	
	previewAnimations.right.daggers:update(dt)
	previewAnimations.right.swordShield:update(dt)
	previewAnimations.right.broadSword:update(dt)
end

function Menu:mainMenu(dt)
	if self.suit:Button('start', 240, 220, 80, 30).hit then
		Gamestate.switch(Game, self.leftInfo, self.rightInfo)
	end
	
	local id = {'daggers', 'swordShield', 'broadSword'}
	for i = 1, 3 do
		if self.suit:Button(tostring(i + 28), 30, 30 * i, 30, 30).hit then
			self.leftInfo.id = id[i]
		end
	end
	for i = 1, 3 do
		if self.suit:Button(tostring(i + 16), 480, 30 * i, 30, 30).hit then
			self.rightInfo.id = id[i]
		end
	end
end

function Menu:draw()
	previewAnimations['left'][self.leftInfo.id]:draw(
		Sprites[self.leftInfo.id].idle,
		120, 40,
		0, 1, 1,
		Sprites[self.leftInfo.id].idle:getWidth()/2/2
	)
	previewAnimations['right'][self.rightInfo.id]:draw(
		Sprites[self.rightInfo.id].idle,
		420, 40,
		0, 1, 1,
		Sprites[self.rightInfo.id].idle:getWidth()/2/2
	)

	self.suit:draw()
end

function drawPreviewAnimation(id, x, y, dir)
	previewAnimations[dir].daggers:draw(Sprites[id].idle, x, y)
	--if id == 'daggers' then
		--previewAnimations[dir].daggers:draw(Sprites.daggers.idle, x, y)
	--elseif id == 'swordShield' then
	
	--elseif id == 'broadSword' then
	
	--end
end

return Menu