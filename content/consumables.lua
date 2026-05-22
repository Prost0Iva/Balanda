SMODS.Atlas({key = 'bda_spectral', path = 'Spectral.png', px = 71, py = 95})

SMODS.Consumable{
    set = 'Tarot',
    atlas = 'ma_tarot',
    key = 'kingpen',
    unlocked = true,
    discovered = false,
    cost = 3,
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 1},
    frames = 10,

    loc_vars = function (self, info_queue, card)
        
    end,

    use = function (self, card, area, copier)
        
    end,

    can_use = function (self, card)
        return true
    end

}