--[[
    GD50
    Final

    Author: Cara Netzer
    cara.netzer@gmail.com
]]

require 'src/Dependencies'

function love.load()
    
    -- make sure that all random #s will always have a different seed #
    math.randomseed(os.time())

    love.window.setTitle('GD50 Final')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    --love.graphics.setFont(gFonts['small'])

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('start')

    --gSounds['music']:setLooping(true)
    --gSounds['music']:play()

    love.keyboard.keysPressed = {}

    --gCamera = Camera(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2)
    --gCamera = Camera()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()

    love.graphics.setBackgroundColor(0, 230/255, 100/255, 1)
    
    --camera:set()

        push:start()
            gStateMachine:render()
        push:finish()
        
    --camera:unset()

end