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
        local can_evo, can_evo_keys = {}, {}
        for k, v in pairs(G.P_CENTERS) do
            if G.P_CENTERS[k].rarity == "bda_evo" then
                if G.P_CENTERS[k].unlocked then
                    can_evo["j" .. k:sub(6)] = true
                end
                can_evo_keys[#can_evo_keys + 1] = "j" .. k:sub(6)
            end
        end

        local temp = false
        local used_tarot = copier or card
        if G.jokers and (#G.jokers.highlighted >= 1) and (#G.jokers.highlighted <= card.ability.extra) then
            for _, v in ipairs(G.jokers.highlighted) do
                if can_evo[v.config.center.key] then
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() v:flip();play_sound('card1', percent);v:juice_up(0.3, 0.3);return true end }))
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() 
                        v:set_ability("j_bda_" .. v.config.center.key:sub(3))
                        v:set_cost()
                        v:juice_up(0.3, 0.3)
                        used_tarot:juice_up(0.3, 0.5)
                    return true end }))
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() v:flip();play_sound('card1', percent);v:juice_up(0.3, 0.3);return true end }))
                    temp = true
                end
            end
        end
        if not temp then
            local key = can_evo_keys[pseudorandom('wild_shard', 1, #can_evo_keys)]
            local joker = create_card("Joker", G.jokers, nil, nil, nil, nil, key)
            joker:add_to_deck()
		    G.jokers:emplace(joker)
            card:juice_up(0.3, 0.3)
        end
        G.jokers:unhighlight_all()
    end,

    can_use = function (self, card)
        return true
    end

}

local perseverance = {
    set = 'Tarot',
    key = "perseverance",
    unlocked = true,
    discovered = false,

    atlas = 'consumables',
	pos = { x = 0, y = 0 },

    config = {
        extra = 1
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_bda_diamond
        return { vars = {card.ability.extra} }
    end,

    use = function (self, card, area, copier)
        for _, v in ipairs(G.hand.highlighted) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() v:flip();play_sound('card1', percent);v:juice_up(0.3, 0.3);return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,func = function ()
                v:set_ability(G.P_CENTERS.m_bda_diamond)
                v:change_suit("Diamonds")
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() v:flip();play_sound('card1', percent);v:juice_up(0.3, 0.3);return true end }))
        end
        G.hand:unhighlight_all()
    end, 

    can_use = function(self, card)
        if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra) then
            return true
        end
    end

}

local content = {
    wild_shard,
    perseverance
}
for _, v in ipairs(content) do
    SMODS.Consumable(v)
end