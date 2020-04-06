local GameOver = {}

function GameOver:enter(from, leftInfo, rightInfo, loser)
	self.from = from

	self._leftInfo = leftInfo
	self._rightInfo = rightInfo
	
	if loser == 1 then self.winner = 2
	elseif loser == 2 then self.winner = 1
	end
	
	self.suit = Suit.new()
end

function GameOver:update(dt)
	if self.suit:Button('PLAY AGAIN', 200, 130, 140, 20).hit then
		Gamestate.switch(Game, self._leftInfo, self._rightInfo)
	end
	if self.suit:Button('MAIN MENU', 200, 175, 140, 20).hit then
		Gamestate.switch(Menu)
	end
end

function GameOver:draw()
	self.from:draw()
	love.graphics.setColor(0, 0, 0, 0.6)
	love.graphics.rectangle('fill', 0, 0, 540, 300)
	love.graphics.setColor(1, 1, 1)
	
	love.graphics.setFont(Fonts.large)
	if self.winner == 1 then
		love.graphics.setColor(0, 1, 1)
	elseif self.winner == 2 then
		love.graphics.setColor(1, 1, 0)
	end
	
	love.graphics.printf('PLAYER '..tostring(self.winner)..' WIN',
			540/2 - 100, 80, 200, 'center')
			
	love.graphics.setFont(Fonts.medium)
	self.suit:draw()
end

return GameOver