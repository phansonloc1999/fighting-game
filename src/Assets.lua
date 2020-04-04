local lg = love.graphics

Sprites = {}

Sprites.daggers = {}
Sprites.daggers.idle = lg.newImage("assets/characters/daggers/idle.png") -- 220 ms per frame
Sprites.daggers.walk = lg.newImage("assets/characters/daggers/walk.png") -- 140 ms per frame
Sprites.daggers.block = lg.newImage("assets/characters/daggers/block.png") -- 1 frame
Sprites.daggers.hit = lg.newImage("assets/characters/daggers/hit.png") -- 1 frame
Sprites.daggers.stab = lg.newImage("assets/characters/daggers/stab.png")

Animations = {}

Animations.daggers = {}
Animations.daggers.idle = {anim = getAnimation(Sprites.daggers.idle, 2, 0.2), image = Sprites.daggers.idle, defaultFacing = "left"}
Animations.daggers.walk = {anim = getAnimation(Sprites.daggers.walk, 4, 0.2), image = Sprites.daggers.walk, defaultFacing = "left"}
Animations.daggers.stab = {anim = getAnimation(Sprites.daggers.stab, 3, 0.2), image = Sprites.daggers.stab, defaultFacing = "left"}