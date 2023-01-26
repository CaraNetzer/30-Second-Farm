

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.entity:changeAnimation('walk-down')
    print('I am in the walk state')

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerWalkState:update(dt)

    local dx,dy = self.entity.x - gCamera.x, self.entity.y - gCamera.y
    gCamera:move(dx/2, dy/2)

    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt  

    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-up')
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-down')
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

    else
        self.entity:changeState('idle')
    
    end

    if love.keyboard.wasPressed('space') then
        --self.entity:changeState('swing-sword')
    end    

end

function PlayerWalkState:render()

    gCamera:attach()

    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    

    gCamera:detach()
end