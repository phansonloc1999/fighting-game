--- Single keypress per frame detection
love.keyboard.keysPressed = {}

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    print(key)
end