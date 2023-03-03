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

    self.howTo = false

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
        gSounds['farming']:setVolume(.35)
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


    if love.keyboard.wasPressed('h') then
        self.howTo = not self.howTo
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


    love.graphics.setColor(155/255, 250/255, 172/255, 1)
    love.graphics.setFont(gFonts['fipps-small'])  
    love.graphics.printf('Press h to toggle How-To', 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')

    if self.howTo then
        love.graphics.setColor(0,0,0, .5)
        love.graphics.rectangle('fill', 0,0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)


        love.graphics.setColor(144/255, 150/255, 146/255, 1)
        love.graphics.rectangle('fill', 46, 20, VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT - 35, 3)
        love.graphics.setColor(242/255, 255/255, 209/255, 1)
        love.graphics.rectangle('fill', 48, 22, VIRTUAL_WIDTH - 100 - 4, VIRTUAL_HEIGHT - 35 - 4, 3)
        love.graphics.setColor(0, 0, 0, 1)

        love.graphics.setFont(gFonts['arcade-small'])  
        love.graphics.printf('How To Play:', 62, 24, VIRTUAL_WIDTH - 128, 'center')
        love.graphics.print('- Head to the garden each morning', 54, 36 + 3)
        love.graphics.print('- Plant and collect as many', 54, 48 + 6)
        love.graphics.print('    vegetables from your garden as', 54, 60 + 6)
        love.graphics.print('    you can without running into moles', 54, 72 + 6)
        love.graphics.print('    before the day is done (Press p', 54, 84 + 6)
        love.graphics.print('    to plant a seed)', 54, 96 + 6)
        love.graphics.print("- Place your day's harvest in the bin", 54, 108 + 9)
        love.graphics.print('    (Press i to deposit inventory)', 54, 120 + 9)
        love.graphics.print('- Another day begins', 54, 132 + 12)
        love.graphics.print('- Discover all 8 plants to win!', 54, 144 + 15)
        love.graphics.print('- In game, press m to return to the', 54, 156 + 15)
        love.graphics.print('    main menu', 54, 168 + 18)
    end
    
   
    
end