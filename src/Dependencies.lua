

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
Camera = require "lib/camera"


--require every file besides main
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'

require 'src/StateMachine'
require 'src/Constants'
require 'src/Animation'
require 'src/Player'
require 'src/entity_defs'
require 'src/Util'
require 'src/Farm'


gTextures = {
    ['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['plants'] = love.graphics.newImage('graphics/plant-sprites.png')
}

gFrames = {
    ['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    ['plants'] = GenerateQuads(gTextures['plants'], 25, 25)
}


gSounds = {
    --['music'] = love.audio.newSource('sounds/music.mp3', 'static'),
    ['plant-blocked'] = love.audio.newSource('graphics/CantPlant.wav', 'static')
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
