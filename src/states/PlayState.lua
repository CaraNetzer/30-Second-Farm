
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = 67,
        y = 95,
        
        width = 16,
        height = 22,

        -- rendering and collision offset for spaced sprites
        offsetY = 5
    }

    self.mole1 = Mole {
        --x = 200,
        --y = 90,
        animations = ENTITY_DEFS['moles'].animations
    }
    self.mole2 = Mole {
        --x = 200,
        --y = 120,
        animations = ENTITY_DEFS['moles'].animations
    }

    self.farm = Farm {
        player = self.player,
        size = 200, --tile width and height
        mole1 = self.mole1,
        mole2 = self.mole2
    }

    self.plants = {}

    self.player.currentAnimation = self.player.animations['idle-down']

    self.waitDuration = 0
    self.waitTimer = 0

    self.backpack = {}
    self.level = 1

    self.dayTime = true
    self.chestGlow = false
    self.chestGlowOpacity = 0

    self.timer = 10
    -- subtract 1 from timer every second
    Timer.every(1, function()
        self.timer = self.timer - 1

        -- play warning sound on timer if we get low
        if self.timer <= 5 then
            --gSounds['clock']:play()
        end

        Timer.tween(.5, {
            [self] = { chestGlowOpacity = 1 }
        })
        print(self.chestGlowOpacity)
        self.chestGlowOpacity = 0
    end)

    

end

function PlayState:growPlants(plant, dt)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(10)
    else
        self.waitTimer = self.waitTimer + dt

        if self.waitTimer > self.waitDuration then
            -- if timer is up, change sprite to the next sapling in the set and reset timers
            if plant.sprite < 4 then
                plant.sprite = plant.sprite + 1
                self.waitTimer = 0
                self.waitDuration = 0
            else -- if we're on the last sapling in the set and the timer is up, change to the plant and stay there
                plant.sprite = 6
            end                
        end
    end
end

function PlayState:update(dt)
    
    self.farm:update()

    if self.dayTime then
        self.mole1:update(dt)
        self.mole2:update(dt)
    else --if the timer runs out, don't render the moles and move them out of the garden
        self.mole1.x = 1000
        self.mole2.x = 1000
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

     -- moles stop, plants clear, chest glows if time runs out
     if self.timer <= 0 then
        Timer.clear()
        self.dayTime = false
        self.chestGlow = true
        self.plants = {}
    end

    -- if self.chestGlow then
    --     Timer.every(1, function()
    --         Timer.tween(.5, {
    --             [self] = { chestGlowOpacity = 1 }
    --         })
            
    --     end)
    -- end

    --if player is located within the garden
    if (self.player.mapX >= 5 and self.player.mapX <= 13 and self.player.mapY >= 2 and self.player.mapY <= 8) then
        --plant random seed based on player direction
        if self.timer > 0 and love.keyboard.wasPressed('p') then
            
            local plant = {
                set = math.random(1,self.level),
                sprite = 1,
                gridX = self.player.mapX + 1,
                gridY = self.player.mapY + 1,
                x = gridX,
                y = gridY,
                width = PLANT_SIZE - 5, -- minus 5 is for collision wiggle room
                height = PLANT_SIZE - 5
            }

            if self.player.direction == 'right' then
                plant.gridY = plant.gridY - 2
                plant.gridX = plant.gridX - 1
                --print(plant.gridX .. ", " .. plant.gridY)
                if plant.gridY >= 1 and plant.gridY <= 6 and plant.gridX >= 6 and plant.gridX <= 12 then
                    --print('right: ' .. self.farm.garden[plant.gridX][plant.gridY].id)
                    if self.farm.garden[plant.gridX][plant.gridY].id == "empty" then
                        
                        self.farm.garden[plant.gridX][plant.gridY].set = plant.set
                        self.farm.garden[plant.gridX][plant.gridY].sprite = plant.sprite

                        
                        self.farm.garden[plant.gridX][plant.gridY].id = "plant"

                        --for rendering at actual pixel position
                        plant.x = (plant.gridX * PLANT_SIZE) + X_OFFSET
                        plant.y = (plant.gridY * PLANT_SIZE) + Y_OFFSET
                        table.insert(self.plants, plant)
                    else
                        gSounds['plant-blocked']:stop()
                        gSounds['plant-blocked']:play()
                    end
                end
            elseif self.player.direction == 'left' then
                plant.gridY = plant.gridY - 2
                plant.gridX = plant.gridX - 3
                --print(plant.gridX .. ", " .. plant.gridY)

                if plant.gridY >= 1 and plant.gridY <= 6 and plant.gridX >= 6 and plant.gridX <= 12 then
                    --print('left: ' .. self.farm.garden[plant.gridX][plant.gridY].id)
                    if self.farm.garden[plant.gridX][plant.gridY].id  == "empty" then
                        
                        self.farm.garden[plant.gridX][plant.gridY].set = plant.set
                        self.farm.garden[plant.gridX][plant.gridY].sprite = plant.sprite

                        
                        self.farm.garden[plant.gridX][plant.gridY].id = "plant"

                        --for rendering at actual pixel position
                        plant.x = (plant.gridX * PLANT_SIZE) + X_OFFSET
                        plant.y = (plant.gridY * PLANT_SIZE) + Y_OFFSET
                        table.insert(self.plants, plant)
                    else
                        gSounds['plant-blocked']:stop()
                        gSounds['plant-blocked']:play()
                    end
                end
            elseif self.player.direction == 'down' then
                plant.gridY = plant.gridY - 2
                plant.gridX = plant.gridX - 2
                --print(plant.gridX .. ", " .. plant.gridY)

                if plant.gridY >= 1 and plant.gridY <= 6 and plant.gridX >= 6 and plant.gridX <= 12 then
                    --print('down: ' .. self.farm.garden[plant.gridX][plant.gridY].id)
                    if self.farm.garden[plant.gridX][plant.gridY].id  == "empty" then
                        
                        self.farm.garden[plant.gridX][plant.gridY].set = plant.set
                        self.farm.garden[plant.gridX][plant.gridY].sprite = plant.sprite

                        
                        self.farm.garden[plant.gridX][plant.gridY].id = "plant"

                        --for rendering at actual pixel position
                        plant.x = (plant.gridX * PLANT_SIZE) + X_OFFSET
                        plant.y = (plant.gridY * PLANT_SIZE) + Y_OFFSET
                        table.insert(self.plants, plant)
                    else
                        gSounds['plant-blocked']:stop()
                        gSounds['plant-blocked']:play()
                    end
                end
            elseif self.player.direction == 'up' then
                plant.gridY = plant.gridY - 3
                plant.gridX = plant.gridX - 2   
                --print(plant.gridX .. ", " .. plant.gridY)

                if plant.gridY >= 1 and plant.gridY <= 6 and plant.gridX >= 6 and plant.gridX <= 12 then
                    --print('up: ' .. self.farm.garden[plant.gridX][plant.gridY].id)
                    if self.farm.garden[plant.gridX][plant.gridY].id  == "empty" then
                        
                        self.farm.garden[plant.gridX][plant.gridY].set = plant.set
                        self.farm.garden[plant.gridX][plant.gridY].sprite = plant.sprite

                        
                        self.farm.garden[plant.gridX][plant.gridY].id = "plant"

                        --for rendering at actual pixel position
                        plant.x = (plant.gridX * PLANT_SIZE) + X_OFFSET
                        plant.y = (plant.gridY * PLANT_SIZE) + Y_OFFSET
                        table.insert(self.plants, plant)
                    else
                        gSounds['plant-blocked']:stop()
                        gSounds['plant-blocked']:play()
                    end
                end
            end
        end
    end

    --grow seeds
    for i, plant in pairs(self.plants) do
        self:growPlants(plant, dt)
    end
   
    --collect plants
    for i, plant in pairs(self.plants) do
        if plant.sprite == 6 then --if plant is fully grown
            if self.player:collides(plant) then 
                --when player collides with a fully grown plant add it to backpack and remove it from plants table
                table.insert(self.backpack, plant)
                self.farm.garden[plant.gridX][plant.gridY].id = "empty"
                table.remove(self.plants, i)

                gSounds['plant-collected']:stop()
                gSounds['plant-collected']:play()

                --print(#self.backpack)
            end
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    self.player:update(dt)


    if love.keyboard.isDown('a') then
        self.player.direction = 'left'
        self.player:changeAnimation('walk-left')
        self.player.x = self.player.x - self.player.walkSpeed * dt  

    elseif love.keyboard.isDown('d') then
        self.player.direction = 'right'
        self.player:changeAnimation('walk-right')
        self.player.x = self.player.x + self.player.walkSpeed * dt

    elseif love.keyboard.isDown('w') then
        self.player.direction = 'up'
        self.player:changeAnimation('walk-up')
        self.player.y = self.player.y - self.player.walkSpeed * dt

    elseif love.keyboard.isDown('s') then
        self.player.direction = 'down'
        self.player:changeAnimation('walk-down')
        self.player.y = self.player.y + self.player.walkSpeed * dt
    
    elseif not love.keyboard.isDown('s', 'w', 'd', 'a') then
        self.player:changeAnimation('idle-' .. self.player.direction)
    end
end

function PlayState:render()  
    
    self.farm:render()
    
    for i, plant in pairs(self.plants) do
        if plant.sprite%6 ~= 0 then --if the sprite is still a sapling
            love.graphics.draw(gTextures['plants'], gFrames['plants'][SAPLING_TILES[plant.set][plant.sprite]], plant.x, plant.y)
        else --if the sapling has grown into a plant
            love.graphics.draw(gTextures['plants'], gFrames['plants'][PLANT_TILES[plant.sprite * plant.set]], plant.x, plant.y)
        end
    end
    
    if self.dayTime then
        self.mole1:render()
        self.mole2:render()        
    end

    if self.chestGlow then
        print(self.chestGlowOpacity)
        love.graphics.setColor(255, 223, 0, self.chestGlowOpacity)
        love.graphics.rectangle('line', VIRTUAL_WIDTH - 25, VIRTUAL_HEIGHT/2, CHEST_WIDTH, CHEST_HEIGHT)
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.player.currentAnimation then
        local anim = self.player.currentAnimation
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    end

    --health GUI
    local healthLeft = self.player.health
    local heartFrame = 1
    for i = 1, 3 do
        if healthLeft > 1 then
            heartFrame = 5
        elseif healthLeft == 1 then
            heartFrame = 5
        else
            heartFrame = 1
        end

        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][heartFrame],
            (i - 1) * (TILE_SIZE + 1), 2)
        
        healthLeft = healthLeft - 1
    end

    --level and backpack GUI
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Level: ' .. self.level, 0, 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Plants: ' .. #self.backpack, 0, 2, VIRTUAL_WIDTH, 'right')
    love.graphics.printf('Timer: ' .. tostring(self.timer), 16*3+20, 0, VIRTUAL_WIDTH)

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.mole1.x, self.mole1.y, self.mole1.width, self.mole1.height)
    -- love.graphics.rectangle('line', self.mole2.x, self.mole2.y, self.mole2.width, self.mole2.height)

end