Farm = Class{}


function Farm:init(def)
    self.player = def.player
    self.size = def.size
    self.grid = {}

    --VIRTUAL_WIDTH = 384 - 9 = 375 (15 tiles wide)
    --VIRTUAL_HEIGHT = 216 - 16 = 200 (8 tiles tall)
    --make a grid of 25x25 sqaures
    for i = 1, 15, 1 do
        self.grid[i] = {}
        for j = 1, 8, 1 do
            table.insert(self.grid[i], {id = "empty", x = X_OFFSET + (i*PLANT_SIZE), y = Y_OFFSET + j*PLANT_SIZE})
        end
    end
end

function Farm:update(dt)

end

function Farm:render()
    love.graphics.setColor(0, 1, 153/255, 1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    --reset color to white    
    love.graphics.setColor(1,1,1,1)

    love.graphics.draw(gTextures['house'], 10, 5, 0, .75, .75)
    love.graphics.draw(gTextures['chest'], VIRTUAL_WIDTH - 25, VIRTUAL_HEIGHT/2, 0, .25, .25)
       
end