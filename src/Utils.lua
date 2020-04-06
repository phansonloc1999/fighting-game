--- Single keypresses, keyreleases per frame detection
love.keyboard.keysPressed = {}

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

love.keyboard.keysReleased = {}

function love.keyboard.wasReleased(key)
    return love.keyboard.keysReleased[key]
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

---@param onLoop boolean
function getAnimation(image, columnCount, intervals, onLoop)
    local grid = Anim8.newGrid(image:getWidth() / columnCount, image:getHeight(), image:getWidth(), image:getHeight())
    return Anim8.newAnimation(grid("1-" .. columnCount, 1), intervals, onLoop)
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