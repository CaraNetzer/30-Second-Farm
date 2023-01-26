

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(player)
    self.entity = player
    -- render offset for spaced character sprite (negated in render function of state)
    print(self.entity.direction)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        --self.entity:changeState('swing-sword')
    end


    if love.keyboard.wasPressed('return') then
    end
end

function PlayerIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end