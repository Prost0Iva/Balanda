SMODS.Sticker{
    key = "mimic",
    atlas = "stickers",
    pos = {x = 0, y = 0},
    badge_colour = HEX("5ee589"),
    rate = 0.0,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local keys_pool, another_joker = {}, false
            for k, v in ipairs(G.jokers.cards) do
                if v ~= card and v.config.center.key ~= "j_bda_mimicry" and not v.ability.bda_mimic then
                    keys_pool[#keys_pool + 1] = v.config.center.key
                    another_joker = true
                    sendDebugMessage("Нашел другого джокера")
                end
            end
            if not another_joker and #keys_pool == 0 then
                for k, v in pairs(G.P_CENTERS) do
                    if G.P_CENTERS[k].unlocked and k:sub(1, 2) == "j_" and k ~= "j_bda_mimicry" then
                        keys_pool[#keys_pool + 1] = k
                    end
                end
            end
        

            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() 
                card:set_ability(keys_pool[pseudorandom('mimicry', 1, #keys_pool)])
                card:add_sticker('bda_mimic', true)
                card:juice_up(0.3, 0.3)
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
        end
        if context.starting_shop then
            card:remove_sticker('bda_mimic')
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() 
                card:set_ability("j_bda_mimicry")
                card:juice_up(0.3, 0.3)
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
        end
    end
}