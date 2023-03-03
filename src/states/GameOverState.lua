--[[ Credit to:

    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)

    
    gSounds['farming']:stop()
    gSounds['game-over']:play()

    --Timer.after(2, function() gStateMachine:change('start') end)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        
        gStateMachine:change('start', {
            exp = 0,
            level = 1,
            day = 1
        })
    end
end



function GameOverState:render()

    love.graphics.setFont(gFonts['fipps-medium'])

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')

    
end