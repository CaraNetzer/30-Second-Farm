--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

FadeOutState = Class{__includes = BaseState}

--didn't end up using this state, but kept as another model of how to do init vs enter
--see state definition in main.lua
--also could use this state to make the day transitions a bit more smooth
function FadeOutState:init(color, time, onFadeComplete, exp)
    self.opacity = 1
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.time = time

    Timer.tween(self.time, {
        [self] = {opacity = 0}
    })
    :finish(function()
        gStateMachine:change('fade-in', {
            exp = exp
        })
        onFadeComplete()
    end)
end

function FadeOutState:update(dt)

end

function FadeOutState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
end