local wild_shard = {
    set = 'Spectral',
    key = 'wild_shard',
    unlocked = false,
    check_for_unlock = function(self, args)
        if G.PROFILES[G.SETTINGS.profile].challenge_progress.completed["c_bda_evo_joker"] then
            unlock_card(self)
        end
    end,
    
    discovered = false,
    cost = 3,
    atlas = 'wild_shard',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0 , y = 1 },

    config = {
        extra = 1
    },

    loc_vars = function (self, info_queue, card)
        return {
            vars = {card.ability.extra}
        }
    end,

    use = function (self, card, area, copier)
        
    end,

    can_use = function (self, card)
        if G.jokers and (#G.jokers.highlighted >= 1) and (#G.jokers.highlighted <= card.ability.extra) then
            return true
        end
    end

}

local content = {
    wild_shard,
}
for _, v in ipairs(content) do
    SMODS.Consumable(v)
end