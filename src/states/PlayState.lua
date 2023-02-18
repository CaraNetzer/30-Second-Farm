
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

    self.farm = Farm {
        player = self.player,
        size = 200 --tile width and height
    }

    self.plants = {}

    self.player.currentAnimation = self.player.animations['idle-down']

    self.waitDuration = 0
    self.waitTimer = 0

end

function PlayState:growPlants(plant, dt)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt

        if self.waitTimer > self.waitDuration then
            -- if timer is up, change sprite to the next sapling in the set
            if plant.sprite < 4 then
                plant.sprite = plant.sprite + 1
                self.waitTimer = 0
                self.waitDuration = 0
                print('ai less than 5: ' .. plant.sprite)
            else -- if we're on the last sapling in the set and the timer is up, change to the plant and stay there
                print('ai: ' .. plant.sprite)
                plant.sprite = 6
            end                
        end
    end
end

function PlayState:checkPlantOverlap(plants)
    --for each plant 
        --check collisions
        --if a collision occurs
            --remove plant from plants
            --play error sound
end

function PlayState:update(dt)


    --manage camera movement    
    camera.x = self.player.x - VIRTUAL_WIDTH/2
    camera.y = self.player.y - VIRTUAL_HEIGHT/2

    local mapWidth = (self.farm.size*TILE_SIZE*1.5)
    local mapHeight = (self.farm.size*TILE_SIZE)
    
    --camera movement
    -- if self.player.x < VIRTUAL_WIDTH/2 then
    --     camera.x = 0
    -- end
    -- if self.player.y < VIRTUAL_HEIGHT/2 then
    --     camera.y = 0    
    -- end
    -- if camera.x > mapWidth - mapWidth/2 then
    --     camera.x = mapWidth - mapWidth/2
    -- end
    -- if camera.y > mapHeight - mapHeight/2 then
    --     camera.y = mapHeight - mapHeight/2    
    -- end
    

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end


    --plant random seed based on player direction
    if love.keyboard.wasPressed('p') then
        local plant = {
            set = math.random(1,9),
            sprite = 1,
            x = self.player.x + 16,
            y = self.player.y
        }

        if self.player.direction == 'right' then
            table.insert(self.plants, plant)
            --checkPlantOverlap(self.plants)
        elseif self.player.direction == 'left' then
            table.insert(self.plants, plant)
            --checkPlantOverlap(self.plants)
        elseif self.player.direction == 'down' then
            table.insert(self.plants, plant)
            --checkPlantOverlap(self.plants)
        elseif self.player.direction == 'up' then
            table.insert(self.plants, plant)
            --checkPlantOverlap(self.plants)
        end
    end

    --ai grow seeds
    for i, plant in pairs(self.plants) do
        self:growPlants(plant, dt)
    end

    --allow player to pick up fully grown plants
    --if PLANT_TILES contains plant.sprite and player is next to a plant
        --add plant to backpack
        --remove plant from self.plants

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    self.player:update(dt)

    --local dx,dy = self.player.x - gCamera.x, self.player.y - gCamera.y
    --gCamera:move(dx/2, dy/2)

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
    
    love.graphics.setColor(0, 1, 153/255, 1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    love.graphics.setColor(1,1,1, 1)
    love.graphics.rectangle("fill", 0, 0, 30, 30)
    
    --love.graphics.setFont(gFonts['zelda'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Play State', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')


    self.farm:render()
    
    for i, plant in pairs(self.plants) do
        print('modulo: ' .. plant.sprite % 6)
        print('sprite in render: ' .. plant.sprite)
        if plant.sprite%6 ~= 0 then
            print('sap: ' .. SAPLING_TILES[plant.set][plant.sprite])
            love.graphics.draw(gTextures['plants'], gFrames['plants'][SAPLING_TILES[plant.set][plant.sprite]], plant.x, plant.y)
        else
            print('plant: ' .. PLANT_TILES[plant.sprite * plant.set])
            love.graphics.draw(gTextures['plants'], gFrames['plants'][PLANT_TILES[plant.sprite * plant.set]], plant.x, plant.y)
        end
    end

    if self.player.currentAnimation then
        local anim = self.player.currentAnimation
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    end


    --love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)

end