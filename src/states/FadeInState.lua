--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

FadeInState = Class{__includes = BaseState}

function FadeInState:enter(def)
    self.r = 1
    self.g = 1
    self.b = 1
    self.opacity = 1
    self.time = 1

    Timer.tween(self.time, {
        [self] = {opacity = 0}
    })
    :finish(function()
        gStateMachine:change('play', {
            exp = def.exp,
            level = def.level,
            day = def.day
        })
        --onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
end