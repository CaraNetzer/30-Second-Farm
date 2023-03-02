--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

FadeInState = Class{__includes = BaseState}

function FadeInState:enter(def)
    self.r = 0
    self.g = 0
    self.b = 0
    self.opacity = 0
    self.time = 1

    Timer.tween(self.time, {
        [self] = {opacity = .5}
    })
    :finish(function()
        gStateMachine:change('play', {
            exp = def.exp
        })
        --onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
end