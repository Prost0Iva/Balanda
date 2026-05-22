SMODS.Atlas({key = 'wild_shard', path = 'WildShard.png', atlas_table = 'ANIMATION_ATLAS', frames = 10, fps = 6, px = 71, py = 95})

SMODS.Consumable{
    set = 'Spectral',
    key = 'wild_shard',
    unlocked = true,
    discovered = false,
    cost = 3,
    atlas = 'wild_shard',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0 , y = 1 },

    loc_vars = function (self, info_queue, card)
        
    end,

    use = function (self, card, area, copier)
        
    end,

    can_use = function (self, card)
        return true
    end

}