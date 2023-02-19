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
            table.insert(self.grid[i], {id = "empty"})
        end
    end
end

function Farm:update(dt)

end

function Farm:render()
    -- love.graphics.setColor(0, 230/255, 100/255, 1)
    -- love.graphics.rectangle("fill", 0, 0, TILE_SIZE*self.size*1.5, TILE_SIZE*self.size)
end