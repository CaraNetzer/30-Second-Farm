

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:enter(player)
    self.entity = player
    self.entity:changeAnimation('idle-' .. self.entity.direction)

    -- render offset for spaced character sprite (negated in render function of state)
    print('I am in the idle state')
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

end

function PlayerIdleState:render()
    self.entity:render()

    print('idle frame: ' .. self.entity.currentAnimation.frames[1])
    
end