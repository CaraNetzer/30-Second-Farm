--[[ Credit to:

    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            exp = 0
        })
    end
end



function StartState:render()

    love.graphics.setColor(0, 1, 153/255, 1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    --love.graphics.setFont(gFonts['zelda'])
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Start state', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    --love.graphics.setFont(gFonts['zelda-small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end