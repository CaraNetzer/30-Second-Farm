Farm = Class{}


function Farm:init(def)
    self.player = def.player
    self.size = def.size
    self.garden = {}
    self.grass = {}
    self.mole1 = def.mole1
    self.mole2 = def.mole2

    --VIRTUAL_WIDTH = 384 - 9 = 375 (15 tiles wide)
    --VIRTUAL_HEIGHT = 216 - 16 = 200 (8 tiles tall)
    --make a grid of 25x25 sqaures
    for i = 5, 14, 1 do
        self.garden[i] = {}
        for j = 3, 7, 1 do
            table.insert(self.garden[i], {id = "empty", x = X_OFFSET + (i*PLANT_SIZE), y = Y_OFFSET + j*PLANT_SIZE})
        end
    end


    --ground tiles
    for y = 1, 14 do
        self.grass[y] = {}
        for x = 1, 24 do
            if y > 3 and y < 12 and x > 10 and x < 21 then --middle dirt
                table.insert(self.grass[y], {x = x, y = y, tileId = 45})
            elseif x == 21 and y == 5 then --right gate
                table.insert(self.grass[y], {x = x, y = y, tileId = 63})
                --table.insert(self.grass[y], {x = x, y = y, tileId = 91})
            elseif x == 10 and y == 10 then --left gate
                table.insert(self.grass[y], {x = x, y = y, tileId = 61})
                --table.insert(self.grass[y], {x = x, y = y, tileId = 91})


            elseif y == 3 and x > 10 and x < 21 then --top edge and fence
                table.insert(self.grass[y], {x = x, y = y, tileId = 54})
                table.insert(self.grass[y], {x = x, y = y, tileId = 74})

            elseif y == 12 and x > 10 and x < 21 then --bottom edge and fence
                table.insert(self.grass[y], {x = x, y = y, tileId = 70})
                table.insert(self.grass[y], {x = x, y = y, tileId = 74})

            elseif x == 10 and y > 3 and y < 12 then --left edge and fence
                table.insert(self.grass[y], {x = x, y = y, tileId = 61})
                table.insert(self.grass[y], {x = x, y = y, tileId = 81})
                
            elseif x == 21 and y > 3 and y < 12 then --right edge and fence
                table.insert(self.grass[y], {x = x, y = y, tileId = 63})
                table.insert(self.grass[y], {x = x, y = y, tileId = 83})
                
            elseif x == 10 and y == 3 then --top left corner
                table.insert(self.grass[y], {x = x, y = y, tileId = math.random(2) == 1 and 46 or 47})
                table.insert(self.grass[y], {x = x, y = y, tileId = 73})
            elseif x == 21 and y == 3 then --top right corner
                table.insert(self.grass[y], {x = x, y = y, tileId = math.random(2) == 1 and 46 or 47})
                table.insert(self.grass[y], {x = x, y = y, tileId = 75})
            elseif x == 10 and y == 12 then --bottom left corner
                table.insert(self.grass[y], {x = x, y = y, tileId = math.random(2) == 1 and 46 or 47})
                table.insert(self.grass[y], {x = x, y = y, tileId = 89})
            elseif x == 21 and y == 12 then --bottom right corner
                table.insert(self.grass[y], {x = x, y = y, tileId = math.random(2) == 1 and 46 or 47})
                table.insert(self.grass[y], {x = x, y = y, tileId = 91})
            
            else --grass
                table.insert(self.grass[y], {x = x, y = y, tileId = math.random(2) == 1 and 46 or 47})
            end
        end
    end


    --moles
    Timer.every(2, function()
        local hole1X = math.random(5, 13)
        local hole1Y = math.random(1, 5)
        local hole2X = math.random(5, 13)
        local hole2Y = math.random(1, 5)

        -- for r, row in pairs(self.garden) do
        --     for h, hole in pairs(row) do
        --         print(r .. '-' .. h .. 'h: ' .. hole.id)
        --     end
        -- end

        --print(self.garden[hole1X][hole1Y].id)
        --if self.garden[hole1X][hole1Y].id ~= 'empty' then
            self.mole1.mapX = hole1X
            self.mole1.mapY = hole1Y
        --end
        --print(self.garden[hole2X][hole2Y].id)
        --if self.garden[hole2X][hole2Y].id ~= 'empty' then
            self.mole2.mapX = hole2X
            self.mole2.mapY = hole2Y
        --end
    end)
end

function Farm:update(dt)

    

    --player collisions
    local fenceIds = {73, 74, 75, 81, 83, 89, 90, 91}
    for t, tile in pairs(self.grass) do
        for f, fence in pairs(fenceIds) do
            if tile.tileId == fence and self.player.x + 16 > tile.x*16 and self.player.x < (tile.x*16)+16 then
                self.player.x = (tile.x*16) - 16
            end
            --try doing it based on x and y values maybe instead of tileIds
        end
    end

end

function Farm:render()
    
    
    --reset color to white    
    love.graphics.setColor(1,1,1,1)

    --ground and fence tiles / grass table
    for i, grassSet in pairs(self.grass) do
        for j, grassTile in pairs(grassSet) do
            love.graphics.draw(gTextures['grass'], gFrames['grass'][grassTile.tileId], (grassTile.x - 1) * TILE_SIZE, (grassTile.y - 1) * TILE_SIZE)
        end
    end

    --house and chest
    love.graphics.draw(gTextures['house'], 10, 5, 0, .75, .75)
    love.graphics.draw(gTextures['chest'], VIRTUAL_WIDTH - 25, VIRTUAL_HEIGHT/2, 0, .25, .25)

    --love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle('line', VIRTUAL_WIDTH - 22, VIRTUAL_HEIGHT/2 + 4, 18, 18)
       
end