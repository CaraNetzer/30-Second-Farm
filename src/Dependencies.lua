

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
Camera = require "lib/camera"


--require every file besides main
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/FadeInState'
require 'src/states/FadeOutState'

require 'src/StateMachine'
require 'src/Constants'
require 'src/Animation'
require 'src/Player'
require 'src/entity_defs'
require 'src/Util'
require 'src/Farm'
require 'src/Mole'


gTextures = {
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['plants'] = love.graphics.newImage('graphics/plant-sprites.png'),
    ['backpack'] = love.graphics.newImage('graphics/backpack.png'),
    ['chest'] = love.graphics.newImage('graphics/better-chest.png'),
    ['house'] = love.graphics.newImage('graphics/house.png'),
    ['grass'] = love.graphics.newImage('graphics/grass.png'),
    ['moles'] = love.graphics.newImage('graphics/moles-transformed.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png')
}

gFrames = {
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['plants'] = GenerateQuads(gTextures['plants'], 25, 25),
    ['backpack'] = GenerateQuads(gTextures['backpack'], 25, 25),
    ['grass'] = GenerateQuads(gTextures['grass'], 16, 16),
    ['moles'] = GenerateMoleQuads(gTextures['moles'], MOLE_WIDTH, MOLE_HEIGHT),
    ['hearts'] = GenerateQuads(gTextures['hearts'], 16, 16)
}


gSounds = {
    --['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['plant-blocked'] = love.audio.newSource('graphics/CantPlant.wav', 'static'),
    ['plant-collected'] = love.audio.newSource('graphics/plant-collected.wav', 'static'),
    ['hit-enemy'] = love.audio.newSource('graphics/hit_enemy.wav', 'static'),
    ['sell-inventory'] = love.audio.newSource('graphics/inventory_sound_effects/leather_inventory.wav', 'static'),
    ['clock'] = love.audio.newSource('graphics/clock.wav', 'static')
}

--[[ 
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['zelda'] = love.graphics.newFont('fonts/zelda.otf', 64),
    ['zelda-small'] = love.graphics.newFont('fonts/zelda.otf', 32)
}

 ]]
