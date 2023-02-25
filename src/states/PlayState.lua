
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 16,
        height = 22,

        -- one heart == 2 health
        health = 6,

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
    self.mole1:update(dt)
    self.mole2:update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    --if player is located within the garden
    if (self.player.mapX >= 5 and self.player.mapX <= 13 and self.player.mapY >= 2 and self.player.mapY <= 8) then
        --plant random seed based on player direction
        if love.keyboard.wasPressed('p') then
            
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
                print(plant.gridX .. ", " .. plant.gridY)
                if plant.gridY >= 3 and plant.gridY <= 7 and plant.gridX >= 5 and plant.gridX <= 12 then
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
                print(plant.gridX .. ", " .. plant.gridY)

                if plant.gridY >= 3 and plant.gridY <= 7 and plant.gridX >= 5 and plant.gridX <= 12 then
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
                print(plant.gridX .. ", " .. plant.gridY)

                if plant.gridY >= 3 and plant.gridY <= 7 and plant.gridX >= 5 and plant.gridX <= 12 then
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
                print(plant.gridX .. ", " .. plant.gridY)

                if plant.gridY >= 3 and plant.gridY <= 7 and plant.gridX >= 5 and plant.gridX <= 12 then
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

    --allow player to pick up fully grown plants
    --if PLANT_TILES contains plant.sprite and player is next to a plant
        --add plant to backpack
        --remove plant from self.plants

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
    
    self.mole1:render()
    self.mole2:render()

    if self.player.currentAnimation then
        local anim = self.player.currentAnimation
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    end



    --love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)

end