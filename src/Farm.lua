Farm = Class{}


function Farm:init(def)
    self.player = def.player
    self.size = def.size
end

function Farm:update(dt)

end

function Farm:render()
    love.graphics.setColor(0, 230/255, 100/255, 1)
    love.graphics.rectangle("fill", 0, 0, TILE_SIZE*self.size*1.5, TILE_SIZE*self.size)
end