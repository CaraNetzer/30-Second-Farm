--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{}

function Player:init(def)
    -- in top-down games, there are four directions instead of two
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.mapX = math.ceil((self.x+X_OFFSET)/25)
    self.mapY = math.ceil((self.y+Y_OFFSET)/25)

    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.walkSpeed = def.walkSpeed

    self.health = def.health

    -- flags for flashing the entity when hit
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0

    -- timer for turning transparency on and off, flashing
    self.flashTimer = 0

    self.dead = false
    self.heartDropped = false
end

function Player:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Player:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Player:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end

    self.mapX = math.ceil((self.x+X_OFFSET)/25)
    self.mapY = math.ceil((self.y+Y_OFFSET)/25)

    --dont let player move off screen
    if self.x > VIRTUAL_WIDTH - self.width then
        self.x = VIRTUAL_WIDTH - self.width
    elseif self.x < 0 then
        self.x = 0
    elseif self.y > VIRTUAL_HEIGHT - self.height then
        self.y = VIRTUAL_HEIGHT - self.height
    elseif self.y < 0  then
        self.y = 0
    end
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:render()
    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0) 
end