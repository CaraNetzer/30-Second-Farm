Mole = Class{}

function Mole:init(def)

    self.animations = self:createAnimations(def.animations)

    -- dimensions
    self.x = PLANT_SIZE*(math.random(6, 11)) - X_OFFSET
    self.y = PLANT_SIZE*(math.random(2, 5)) - Y_OFFSET
    self.width = MOLE_WIDTH
    self.height = MOLE_HEIGHT
    self.mapX = math.ceil((self.x+X_OFFSET)/PLANT_SIZE)
    self.mapY = math.ceil((self.y+Y_OFFSET)/PLANT_SIZE)

    self.currentAnimation = self.animations['moles']

    

    -- timer for turning transparency on and off, flashing
    self.flashTimer = 0

end

function Mole:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval, 
            looping = animationDef.looping
        }
    end

    return animationsReturned
end

function Mole:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Mole:update(dt)

    --if self.currentAnimation.currentFrame ~= 5 then
        self.currentAnimation:update(dt)
    --end


end

function Mole:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end



function Mole:render()
    if self.currentAnimation then
        local anim = self.currentAnimation
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            (self.mapX*PLANT_SIZE)+X_OFFSET, (self.mapY*PLANT_SIZE)+Y_OFFSET, 0, 1)
    end

end