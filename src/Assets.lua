local lg = love.graphics

Fonts = {
    small = lg.newFont("assets/Robot_Font.otf", 16),
    medium = lg.newFont("assets/Robot_Font.otf", 24),
    large = lg.newFont("assets/Robot_Font.otf", 30),
    gigantic = lg.newFont("assets/Robot_Font.otf", 50)
}

do
    Sprites = {}

    Sprites.daggers = {}
    Sprites.daggers.idle = lg.newImage("assets/characters/daggers/idle.png") -- 220 ms per frame
    Sprites.daggers.walk = lg.newImage("assets/characters/daggers/walk.png") -- 140 ms per frame
    Sprites.daggers.block = lg.newImage("assets/characters/daggers/block.png") -- 1 frame
    Sprites.daggers.hit = lg.newImage("assets/characters/daggers/hit.png") -- 1 frame
    Sprites.daggers.attack = lg.newImage("assets/characters/daggers/stab.png")
    Sprites.daggers.doubleStab = lg.newImage("assets/characters/daggers/doubleStab.png")

    Sprites.swordShield = {}
    Sprites.swordShield.idle = lg.newImage("assets/characters/swordShield/idle.png") -- 220 ms per frame
    Sprites.swordShield.walk = lg.newImage("assets/characters/swordShield/walk.png") -- 140 ms per frame
    Sprites.swordShield.block = lg.newImage("assets/characters/swordShield/block.png") -- 1 frame
    Sprites.swordShield.hit = lg.newImage("assets/characters/swordShield/hit.png") -- 1 frame
    Sprites.swordShield.attack = lg.newImage("assets/characters/swordShield/strike.png")

    Sprites.broadSword = {}
    Sprites.broadSword.idle = lg.newImage("assets/characters/broadSword/idle.png") -- 220 ms per frame
    Sprites.broadSword.walk = lg.newImage("assets/characters/broadSword/walk.png") -- 140 ms per frame
    Sprites.broadSword.block = lg.newImage("assets/characters/broadSword/block.png") -- 1 frame
    Sprites.broadSword.hit = lg.newImage("assets/characters/broadSword/hit.png") -- 1 frame
    Sprites.broadSword.attack = lg.newImage("assets/characters/broadSword/jumpStrike.png")

    Sprites.healthbar = lg.newImage("assets/healthbar.png")

    Animations = {}

    Animations.daggers = {}
    Animations.daggers.idle = {
        anim = getAnimation(Sprites.daggers.idle, 2, 0.22, nil),
        image = Sprites.daggers.idle,
        defaultFacing = "left"
    }
    Animations.daggers.walk = {
        anim = getAnimation(Sprites.daggers.walk, 4, 0.14, nil),
        image = Sprites.daggers.walk,
        defaultFacing = "left"
    }
    Animations.daggers.attack = {
        anim = getAnimation(Sprites.daggers.attack, 3, {0.05, 0.1, 0.05}, "pauseAtEnd"),
        image = Sprites.daggers.attack,
        defaultFacing = "left"
    }
    Animations.daggers.block = {
        anim = getAnimation(Sprites.daggers.block, 1, 1, "pauseAtEnd"),
        image = Sprites.daggers.block,
        defaultFacing = "left"
    }
    Animations.daggers.hit = {
        anim = getAnimation(Sprites.daggers.hit, 1, 0.3, "pauseAtEnd"),
        image = Sprites.daggers.hit,
        defaultFacing = "right"
    }
    Animations.daggers.attack1 = {
        anim = getAnimation(Sprites.daggers.doubleStab, 4, {0.2, 0.1, 0.1, 0.2}, "pauseAtEnd"),
        image = Sprites.daggers.doubleStab,
        defaultFacing = "left"
    }

    Animations.swordShield = {}
    Animations.swordShield.idle = {
        anim = getAnimation(Sprites.swordShield.idle, 2, 0.22, nil),
        image = Sprites.swordShield.idle,
        defaultFacing = "left"
    }
    Animations.swordShield.walk = {
        anim = getAnimation(Sprites.swordShield.walk, 4, 0.14, nil),
        image = Sprites.swordShield.walk,
        defaultFacing = "left"
    }
    Animations.swordShield.attack = {
        anim = getAnimation(Sprites.swordShield.attack, 3, {0.08, 0.116, 0.1}, "pauseAtEnd"),
        image = Sprites.swordShield.attack,
        defaultFacing = "left"
    }
    Animations.swordShield.block = {
        anim = getAnimation(Sprites.swordShield.block, 1, 1, "pauseAtEnd"),
        image = Sprites.swordShield.block,
        defaultFacing = "left"
    }
    Animations.swordShield.hit = {
        anim = getAnimation(Sprites.swordShield.hit, 1, 0.3, "pauseAtEnd"),
        image = Sprites.swordShield.hit,
        defaultFacing = "right"
    }

    Animations.broadSword = {}
    Animations.broadSword.idle = {
        anim = getAnimation(Sprites.broadSword.idle, 2, 0.22, nil),
        image = Sprites.broadSword.idle,
        defaultFacing = "left"
    }
    Animations.broadSword.walk = {
        anim = getAnimation(Sprites.broadSword.walk, 4, 0.14, nil),
        image = Sprites.broadSword.walk,
        defaultFacing = "left"
    }
    Animations.broadSword.attack = {
        anim = getAnimation(Sprites.broadSword.attack, 3, {0.116, 0.084, 0.15}, "pauseAtEnd"),
        image = Sprites.broadSword.attack,
        defaultFacing = "left"
    }
    Animations.broadSword.block = {
        anim = getAnimation(Sprites.broadSword.block, 1, 1, "pauseAtEnd"),
        image = Sprites.broadSword.block,
        defaultFacing = "left"
    }
    Animations.broadSword.hit = {
        anim = getAnimation(Sprites.broadSword.hit, 1, 0.3, "pauseAtEnd"),
        image = Sprites.broadSword.hit,
        defaultFacing = "right"
    }
end

MoveData = {
    -- Daggers
    daggers = {
        attack = {
            frame = {
                startUp = 3,
                active = 1,
                recovery = 10
            },
            hitbox = {
                left = {
                    x = -27,
                    y = 60,
                    w = 35,
                    h = 15
                },
                right = {
                    x = 42,
                    y = 60,
                    w = 35,
                    h = 15
                }
            },
            damage = 12
        },
        attack1 = {
            frame = {
				startUp = 3,
                active = 1,
                recovery = 30
            },
            hitbox = {
                left = {
                    x = -27,
                    y = 60,
                    w = 35,
                    h = 15
                },
                right = {
                    x = 42,
                    y = 60,
                    w = 35,
                    h = 15
                }
            },
            damage = 24
        }
    },
    -- SwordShield
    swordShield = {
        attack = {
            frame = {
                startUp = 4,
                active = 1,
                recovery = 15
            },
            hitbox = {
                left = {
                    x = -32,
                    y = 67,
                    w = 40,
                    h = 10
                },
                right = {
                    x = 42,
                    y = 67,
                    w = 40,
                    h = 10
                }
            },
            damage = 15
        }
    },
    -- BroadSword
    broadSword = {
        attack = {
            frame = {
                startUp = 6,
                active = 1,
                recovery = 20
            },
            hitbox = {
                left = {
                    x = -78,
                    y = 75,
                    w = 70,
                    h = 19
                },
                right = {
                    x = 60,
                    y = 70,
                    w = 70,
                    h = 25
                }
            },
            damage = 20
        }
    }
}

Sprites.environment = {
    tree1 = lg.newImage("assets/environment/tree1.png"),
    tree2 = lg.newImage("assets/environment/tree2.png"),
    bush1 = lg.newImage("assets/environment/bush1.png"),
    bush2 = lg.newImage("assets/environment/bush2.png"),
    bush3 = lg.newImage("assets/environment/bush3.png"),
    twig1 = lg.newImage("assets/environment/twig1.png"),
    twig2 = lg.newImage("assets/environment/twig2.png"),
    twig3 = lg.newImage("assets/environment/twig3.png")
}

CharacterStats = {
    daggers = {
        speed = 150
    },
    swordShield = {
        speed = 120
    },
    broadSword = {
        speed = 90
    }
}
