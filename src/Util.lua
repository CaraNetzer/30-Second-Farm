--[[Credit to: 

    GD50
    Legend of Zelda

    Util Class

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

function GenerateHouseQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local spritesheet = {}

    spritesheet[1] = love.graphics.newQuad(400 + (3*9)-1, 2, tilewidth, tileheight, atlas:getDimensions())
    spritesheet[2] = love.graphics.newQuad(400 + (3*9)-1, tileheight + 5, tilewidth, tileheight, atlas:getDimensions())
    spritesheet[3] = love.graphics.newQuad(600 + (3*13)-1, tileheight + 5, tilewidth, tileheight, atlas:getDimensions())

    return spritesheet
end

function GenerateMoleQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local spritesheet = {}

    spritesheet[1] = love.graphics.newQuad(0, 0, MOLE_WIDTH, MOLE_HEIGHT, atlas:getDimensions())
    spritesheet[2] = love.graphics.newQuad(MOLE_WIDTH + 6, 0, MOLE_WIDTH, MOLE_HEIGHT, atlas:getDimensions())
    spritesheet[3] = love.graphics.newQuad((MOLE_WIDTH*2) + 8, 0, MOLE_WIDTH, MOLE_HEIGHT, atlas:getDimensions())
    spritesheet[4] = love.graphics.newQuad((MOLE_WIDTH*3) + 8, 0, MOLE_WIDTH, MOLE_HEIGHT, atlas:getDimensions())
    spritesheet[5] = love.graphics.newQuad((MOLE_WIDTH*3) + 8, 0, MOLE_WIDTH, MOLE_HEIGHT, atlas:getDimensions())
    spritesheet[6] = love.graphics.newQuad((MOLE_WIDTH*6), 0, MOLE_WIDTH, MOLE_HEIGHT, atlas:getDimensions())
    
    return spritesheet
end