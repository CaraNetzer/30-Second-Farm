

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(player)
    self.entity = player
    self.entity:changeAnimation('idle-' .. self.entity.direction)

    -- render offset for spaced character sprite (negated in render function of state)
    print('I am in the idle state')
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    print('updateee')
    print(self.entity.currentAnimation.frames[1])

    self.entity:update()

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        --self.entity:changeState('swing-sword')
    end

end

function PlayerIdleState:render()
    self.entity:render()

    print(self.entity.currentAnimation.frames[1])
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))


    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(255, 255, 255, 255)
end