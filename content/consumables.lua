local wild_shard = {
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

local content = {
    wild_shard,
}
for _, v in ipairs(content) do
    SMODS.Consumable(v)
end