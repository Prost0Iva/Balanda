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
        local temp = false
        if G.jokers and (#G.jokers.highlighted >= 1) and (#G.jokers.highlighted <= card.ability.extra) then
            for _, v in ipairs(G.jokers.highlighted) do
                if G.GAME.bda_evo_list[v.config.center.key] then
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('card1', percent);v:juice_up(0.3, 0.3);return true end }))
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        v.config = G.P_CENTERS[G.GAME.bda_evo_list[v.config.center.key]]
                        card:juice_up(0.3, 0.5)
                    return {message = localize("k_bda_evo"), colour = HEX("9415e3")} end }))
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('card1', percent);v:juice_up(0.3, 0.3);return true end }))
                    temp = true
                end
            end
        end
        if not temp then
            local joker_id = G.GAME.bda_evo_list[G.GAME.bda_evo_list[pseudorandom('wild_shard', 1, #G.GAME.bda_evo_list)]]
            local joker = create_card("Joker", G.jokers, nil, nil, nil, nil, joker_id)
            joker:add_to_deck()
		    G.jokers:emplace(joker)
        end
        G.jokers:unhighlight_all()
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