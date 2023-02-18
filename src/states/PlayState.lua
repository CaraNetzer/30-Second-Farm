
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

end

function PlayState:update(dt)


    --manage camera movement    
    camera.x = self.player.x - VIRTUAL_WIDTH/2
    camera.y = self.player.y - VIRTUAL_HEIGHT/2

    local mapWidth = (self.farm.size*TILE_SIZE*1.5)
    local mapHeight = (self.farm.size*TILE_SIZE)
    
    if self.player.x < VIRTUAL_WIDTH/2 then
        camera.x = 0
    end
    if self.player.y < VIRTUAL_HEIGHT/2 then
        camera.y = 0    
    end
    if camera.x > mapWidth - mapWidth/2 then
        camera.x = mapWidth - mapWidth/2
    end
    if camera.y > mapHeight - mapHeight/2 then
        camera.y = mapHeight - mapHeight/2    
    end
    




    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('p') then
        if self.player.direction == 'right' then
            table.insert(self.plants, {
                sprite = math.random(2, 35),
                x = self.player.x + 16,
                y = self.player.y
            })
        elseif self.player.direction == 'left' then
            table.insert(self.plants, {
                sprite = math.random(2, 35),
                x = self.player.x - 25,
                y = self.player.y
            })
        elseif self.player.direction == 'down' then
            table.insert(self.plants, {
                sprite = math.random(2, 35),
                x = self.player.x - 5,
                y = self.player.y + 16
            })
        elseif self.player.direction == 'up' then
            table.insert(self.plants, {
                sprite = math.random(2, 35),
                x = self.player.x - 5,
                y = self.player.y - 25
            })
        end
    end

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
        love.graphics.draw(gTextures['plants'], gFrames['plants'][SAPLING_TILES[plant.sprite]], plant.x, plant.y)
    end

    if self.player.currentAnimation then
        local anim = self.player.currentAnimation
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    end


    --love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)

end