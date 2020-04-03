---@class CollisionBox
CollisionBox = Class{}

function CollisionBox:init(x, y, width, height)
    self.x, self.y = x, y
    self.width, self.height = width, height
end

function CollisionBox:draw()
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

function CollisionBox:collidesWith(other)
    return self.x < other.x + other.width and
           other.x < self.x + self.width and
           self.y < other.y + other.height and
           other.y < self.y + self.height
end

function CollisionBox:offsetPos(offsetX, offsetY)
    self.x, self.y = self.x + offsetX, self.y + offsetY
end