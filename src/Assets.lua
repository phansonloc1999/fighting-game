local lg = love.graphics

Sprites = {}

Sprites.daggers = {}
Sprites.daggers.idle = lg.newImage("assets/characters/daggers/idle.png") -- 220 ms per frame
Sprites.daggers.walk = lg.newImage("assets/characters/daggers/walk.png") -- 140 ms per frame
Sprites.daggers.block = lg.newImage("assets/characters/daggers/block.png") -- 1 frame
Sprites.daggers.hit = lg.newImage("assets/characters/daggers/hit.png") -- 1 frame
Sprites.daggers.stab = lg.newImage("assets/characters/daggers/stab.png")

Sprites.swordShield = {}
Sprites.swordShield.idle = lg.newImage("assets/characters/swordShield/idle.png") -- 220 ms per frame
Sprites.swordShield.walk = lg.newImage("assets/characters/swordShield/walk.png") -- 140 ms per frame
Sprites.swordShield.block = lg.newImage("assets/characters/swordShield/block.png") -- 1 frame
Sprites.swordShield.hit = lg.newImage("assets/characters/swordShield/hit.png") -- 1 frame
Sprites.swordShield.stab = lg.newImage("assets/characters/swordShield/strike.png")

Sprites.broadSword = {}
Sprites.broadSword.idle = lg.newImage("assets/characters/broadSword/idle.png") -- 220 ms per frame
Sprites.broadSword.walk = lg.newImage("assets/characters/broadSword/walk.png") -- 140 ms per frame
Sprites.broadSword.block = lg.newImage("assets/characters/broadSword/block.png") -- 1 frame
Sprites.broadSword.hit = lg.newImage("assets/characters/broadSword/hit.png") -- 1 frame
Sprites.broadSword.stab = lg.newImage("assets/characters/broadSword/jumpStrike.png")


Sprites.healthbar = lg.newImage('assets/healthbar.png')


Animations = {}

Animations.daggers = {}
Animations.daggers.idle = {anim = getAnimation(Sprites.daggers.idle, 2, 0.22, "pauseAtEnd"), image = Sprites.daggers.idle, defaultFacing = "left"}
Animations.daggers.walk = {anim = getAnimation(Sprites.daggers.walk, 4, 0.14, "pauseAtEnd"), image = Sprites.daggers.walk, defaultFacing = "left"}
Animations.daggers.stab = {anim = getAnimation(Sprites.daggers.stab, 3, {0.1, 0.16, 0.1}, "pauseAtEnd"), image = Sprites.daggers.stab, defaultFacing = "left"}
Animations.daggers.block = {anim = getAnimation(Sprites.daggers.block, 1, 1, "pauseAtEnd"), image = Sprites.daggers.block, defaultFacing = "left"}
Animations.daggers.hit = {anim = getAnimation(Sprites.daggers.hit, 1, 1, "pauseAtEnd"), image = Sprites.daggers.hit, defaultFacing = "right"}

Animations.swordShield = {}
Animations.swordShield.idle = {anim = getAnimation(Sprites.swordShield.idle, 2, 0.22, "pauseAtEnd"), image = Sprites.swordShield.idle, defaultFacing = "left"}
Animations.swordShield.walk = {anim = getAnimation(Sprites.swordShield.walk, 4, 0.14, "pauseAtEnd"), image = Sprites.swordShield.walk, defaultFacing = "left"}
Animations.swordShield.stab = {anim = getAnimation(Sprites.swordShield.stab, 3, {0.1, 0.16, 0.1}, "pauseAtEnd"), image = Sprites.swordShield.stab, defaultFacing = "left"}
Animations.swordShield.block = {anim = getAnimation(Sprites.swordShield.block, 1, 1, "pauseAtEnd"), image = Sprites.swordShield.block, defaultFacing = "left"}
Animations.swordShield.hit = {anim = getAnimation(Sprites.swordShield.hit, 1, 1, "pauseAtEnd"), image = Sprites.swordShield.hit, defaultFacing = "right"}

Animations.broadSword = {}
Animations.broadSword.idle = {anim = getAnimation(Sprites.broadSword.idle, 2, 0.22, "pauseAtEnd"), image = Sprites.broadSword.idle, defaultFacing = "left"}
Animations.broadSword.walk = {anim = getAnimation(Sprites.broadSword.walk, 4, 0.14, "pauseAtEnd"), image = Sprites.broadSword.walk, defaultFacing = "left"}
Animations.broadSword.stab = {anim = getAnimation(Sprites.broadSword.stab, 3, {0.1, 0.16, 0.1}, "pauseAtEnd"), image = Sprites.broadSword.stab, defaultFacing = "left"}
Animations.broadSword.block = {anim = getAnimation(Sprites.broadSword.block, 1, 1, "pauseAtEnd"), image = Sprites.broadSword.block, defaultFacing = "left"}
Animations.broadSword.hit = {anim = getAnimation(Sprites.broadSword.hit, 1, 1, "pauseAtEnd"), image = Sprites.broadSword.hit, defaultFacing = "right"}