local Healthbar = Class{}

function Healthbar:init(leftPlayer, rightPlayer, healthKey)
	self.leftPlayer = leftPlayer
	self.rightPlayer = rightPlayer
	self.key = healthKey
	
	self.maxHealth = leftPlayer[healthKey]
	self.leftRatio = 1
	self.rightRatio = 1
end

function Healthbar:update(dt)
	self.leftRatio = self.leftPlayer[self.key] / self.maxHealth
	self.rightRatio = self.rightPlayer[self.key] / self.maxHealth
end

function Healthbar:draw()
	self:drawHealth(self.leftRatio, 12, 12, 240, 24, 1)
	self:drawHealth(self.rightRatio, love.graphics.getWidth() - 12, 12, 240, 24, -1)

	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.healthbar, 12, 12)
	love.graphics.draw(Sprites.healthbar,
			love.graphics.getWidth() - 12, 12, 0, -1, 1)
end

function Healthbar:drawHealth(ratio, x, y, w, h, dir)
	love.graphics.setColor(self.pickHealthColor(ratio))
	if ratio < 0 then
		ratio = 0
	end
	love.graphics.rectangle('fill', x, y, w * ratio * dir, h)
end

function Healthbar.pickHealthColor(ratio)
	local r, g, b
	if ratio > 0.75 then
		r, g, b = 255, 210, 20
	elseif ratio > 0.5 then
		r, g, b = 255, 150, 20
	elseif ratio > 0.25 then
		r, g, b = 255, 91, 20
	else
		r, g, b = 225, 20, 22
	end
	return r/255, g/255, b/255
end

return Healthbar