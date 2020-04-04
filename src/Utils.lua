--- Single keypress per frame detection
love.keyboard.keysPressed = {}

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

---@param onLoop boolean
function getAnimation(image, columnCount, interval, onLoop)
    local grid = Anim8.newGrid(image:getWidth() / columnCount, image:getHeight(), image:getWidth(), image:getHeight())
    return Anim8.newAnimation(grid("1-" .. columnCount, 1), interval, onLoop)
end

--- Clone from source animations table of which each element is { anim = anim8Animation, image = love2dImage }
function cloneAnimations(source, isFacing)
    local animations = {}
    for key, animation in pairs(source) do
        animations[key] = {anim = animation.anim:clone(), image = animation.image}

        if (animation.defaultFacing ~= isFacing) then
            animations[key].anim = animations[key].anim:flipH()
        end
    end
    return animations
end