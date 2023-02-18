

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_SIZE = 16

--
-- entity constants
--
PLAYER_WALK_SPEED = 60

--
-- map constants
--
MAP_WIDTH = VIRTUAL_WIDTH / TILE_SIZE - 2
MAP_HEIGHT = math.floor(VIRTUAL_HEIGHT / TILE_SIZE) - 2

MAP_RENDER_OFFSET_X = (VIRTUAL_WIDTH - (MAP_WIDTH * TILE_SIZE)) / 2
MAP_RENDER_OFFSET_Y = (VIRTUAL_HEIGHT - (MAP_HEIGHT * TILE_SIZE)) / 2



--
-- tile IDs
--
TILE_EMPTY = 49

SAPLING_TILES = {
    [1] = {2, 3, 4, 5},
    [2] = {8, 9, 10, 11},
    [3] = {14, 15, 16, 17}, 
    [4] = {20, 21, 22, 23}, 
    [5] = {26, 27, 28, 29},
    [6] = {32, 33, 34, 35},
    [7] = {38, 39, 40, 41},
    [8] = {44, 45, 46, 47},
    [9] = {50, 51, 52}
}

PLANT_TILES = {
    6, 12, 18, 24, 30, 36, 42, 48, 54
}