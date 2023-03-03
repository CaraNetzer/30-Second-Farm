--[[ Credit to:

    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.grassTile = math.random(2) == 1 and 46 or 47

    self.plant = 1    
    
    self.pauseTimer = 0
    self.blinkTimer = 0
    
    self.enterBlink = true

    Event.on('switch-plant', function()
        if self.plant < 8 then
            self.plant = self.plant + 1
        else
            self.plant = 1
        end
    end)

    Event.on('blink', function()
        self.enterBlink = not self.enterBlink
        if self.blink == true then --shorter off period than on period
            self.blinkTimer = 0
        else 
            self.blinkTimer = .5
        end
    end)
    
end

function StartState:update(dt)
    gSounds['start-menu']:play()

    Timer.clear()

    gSounds['game-over']:stop()
    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['start-menu']:stop()
        gSounds['farming']:setLooping(true)
        gSounds['farming']:setVolume(.5)
        gSounds['farming']:play()
        gStateMachine:change('play', {
            exp = 0,
            level = 1,
            day = 1
        })
    end

    local wait = .5
    self.pauseTimer = self.pauseTimer + dt
    if self.pauseTimer > wait then
        Event.dispatch('switch-plant')
        self.pauseTimer = 0
    end
    
    local blink = .8
    self.blinkTimer = self.blinkTimer + dt
    if self.blinkTimer > blink then
        --Event.dispatch('blink')
        self.enterBlink = not self.enterBlink
        if self.enterBlink == true then --shorter off period than on period
            self.blinkTimer = 0
        else 
            self.blinkTimer = .25
        end
    end

end



function StartState:render()

    for i=0, VIRTUAL_WIDTH, TILE_SIZE do
        for j=0, VIRTUAL_HEIGHT, TILE_SIZE do
            love.graphics.draw(gTextures['grass'], gFrames['grass'][self.grassTile], i, j)
            
        end
    end

    --love.graphics.setColor(0, 1, 153/255, 1)
    --love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    
    love.graphics.setFont(gFonts['fipps-medium'])    
    
    love.graphics.setColor(242/255, 255/255, 209/255, 1)
    love.graphics.printf('30 Second Farm', 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')
    
    if self.enterBlink then
        --love.graphics.setColor(242/255, 255/255, 209/255, 1)
        love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    end
    
    --render decorative plants
    love.graphics.setColor(1, 1, 1, 1)
    for i = 1, 13, 1 do
        love.graphics.draw(gTextures['plants'], gFrames['plants'][PLANT_TILES[6 * self.plant]], i*PLANT_SIZE, PLANT_SIZE)
    end
    for i = 1, 13, 1 do
        love.graphics.draw(gTextures['plants'], gFrames['plants'][PLANT_TILES[6 * self.plant]], i*PLANT_SIZE, 6*PLANT_SIZE)
    end
    for j = 2, 5, 1 do
        love.graphics.draw(gTextures['plants'], gFrames['plants'][PLANT_TILES[6 * self.plant]], PLANT_SIZE, j*PLANT_SIZE)
    end
    for j = 2, 5, 1 do
        love.graphics.draw(gTextures['plants'], gFrames['plants'][PLANT_TILES[6 * self.plant]], 13*PLANT_SIZE, j*PLANT_SIZE)
    end

    
end