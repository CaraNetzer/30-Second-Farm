

ENTITY_DEFS = {
    ['moles'] = {
        animations = {
            ['moles'] = {
                frames = {5, 4, 4, 3, 3, 2, 2, 1, 1, 1, 1, 1, 1,1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 6},
                interval = 0.1,
                texture = 'moles', 
                looping = false
            }
        }
    },
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                texture = 'character-walk'
            },
            ['idle-left'] = {
                frames = {13},
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = {5},
                texture = 'character-walk'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'character-walk'
            },
            ['idle-up'] = {
                frames = {9},
                texture = 'character-walk'
            }
        }
    }
}