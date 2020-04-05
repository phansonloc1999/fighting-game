local Menu = {}

function Menu:enter()
	Tick.framerate = -1
	Tick.rate = 0.01

	self.suit = Suit.new()
	
	self.leftInfo = {}
	self.rightInfo = {}
	
	self.currentFrame = 'main'
end

function Menu:update(dt)
	if self.currentFrame == 'main' then
		if self.suit:Button('start', 240, 220, 80, 30).hit then
			Gamestate.switch(Game, {}, {})
		end
	
	elseif self.currentFrame == 'keybinding' then
	
	end
end

function Menu:draw()
	self.suit:draw()
end

return Menu