local calendar = { --Calendar
    key = "calendar",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 1, y = 0},
    cost = 5,
    blueprint_compat = true,

    discovered = false,
    unlocked = true,

    config = {
        wday = 0,
        h_size = 0,
        extra = {
            chips = 50,
            mult = 8,
            xmult = 1.5,
            dollars = 5,
            h_size = 1,
            hands = 1,
            discards = 1

        }
    },

    calculate = function(self, card, context)
        if card.ability.wday == 0 then --Получаем день недели при получении джокера
            local date = os.date("*t")
            card.ability.wday = date.wday

            if card.ability.wday == 6 then --Пятница размер руки
                card.ability.h_size = card.ability.extra.h_size
                G.hand:change_size(card.ability.h_size)
            end
        end
        
        if context.setting_blind then --При выборе блайнда проверяем сегодняшний день недели
            if card.ability.wday == 7 then --Суббота рука
                ease_hands_played(card.ability.extra.hands)
            end
            if card.ability.wday == 1 then --Воскресенье сброс
                ease_discard(card.ability.extra.discards)
            end
        end

        if context.joker_main then 
            if card.ability.wday == 2 then --Понедельник - фишки
                return {
                    chips = card.ability.extra.chips
                }
            end
            if card.ability.wday == 3 then --Вторник - множ
                return {
                    mult = card.ability.extra.mult
                }
            end
            if card.ability.wday == 4 then --Среда хмнож
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

	end,
    calc_dollar_bonus = function(self, card)
        if card.ability.wday == 5 then --Четверг деньги
            return card.ability.extra.dollars
        end
    end,

    loc_vars = function (self, info_queue, card)
        local wday_table = {localize("bda_sun"), localize("bda_mon"), localize("bda_tue"), localize("bda_wed"), localize("bda_thu"), localize("bda_fri"), localize("bda_sat")}
        local main_end = {
            {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                {n=G.UIT.C, config={align = "m", colour = G.C.BLUE, r = 0.05, padding = 0.05}, nodes={
                    {n=G.UIT.T, config={text = ' '..(wday_table[card.ability.wday] or localize('k_none'))..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }
        if card.ability.wday ~= 0 then
            if card.ability.wday == 1 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_sun_eff', vars = {card.ability.extra.discards}}
            end
            if card.ability.wday == 2 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_mon_eff', vars = {card.ability.extra.chips}}
            end
            if card.ability.wday == 3 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_tue_eff', vars = {card.ability.extra.mult}}
            end
            if card.ability.wday == 4 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_wed_eff', vars = {card.ability.extra.xmult}}
            end
            if card.ability.wday == 5 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_thu_eff', vars = {card.ability.extra.dollars}}
            end
            if card.ability.wday == 6 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_fri_eff', vars = {card.ability.extra.h_size}}
            end
            if card.ability.wday == 7 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'bda_sat_eff', vars = {card.ability.extra.hands}}
            end
        else
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_sun_eff', vars = {card.ability.extra.discards}}
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_mon_eff', vars = {card.ability.extra.chips}}
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_tue_eff', vars = {card.ability.extra.mult}}
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_wed_eff', vars = {card.ability.extra.xmult}}
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_thu_eff', vars = {card.ability.extra.dollars}}
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_fri_eff', vars = {card.ability.extra.h_size}}
            info_queue[#info_queue+1] = {set = 'Other', key = 'bda_sat_eff', vars = {card.ability.extra.hands}}
        end

        return {
			main_end = main_end
        }
    end
}

local teto = { --Teto
    key = "teto",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,

    discovered = false,
    unlocked = false,
    unlock_condition = {type = '', extra = '', hidden = true},

    config = {
        date = {
            day = 0,
            month = 0
        },
        extra = 1
    },

    calculate = function(self, card, context)
        if card.ability.date.day == 0 and card.ability.date.month == 0 then --Получаем дату при получении джокера
            local date = os.date("*t")
            card.ability.date = {day = date.day, month = date.month}
            if card.ability.date.day == 1 and card.ability.date.month == 4 then
                sendDebugMessage("*31")
                card.ability.extra = card.ability.extra * 31
            end
        end
        
        if context.joker_main then
            return {
                xmult = card.ability.extra * G.GAME.bda_fools_count + 1
            }
        end
	end,

    loc_vars = function (self, info_queue, card)
        local xmult = card.ability.extra * G.GAME.bda_fools_count + 1
        info_queue[#info_queue+1] = G.P_CENTERS.c_fool
        return {
            vars = {
                card.ability.extra,
                xmult
            }
        }
    end
}

local steve = {
    key = "steve",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 2, y = 0},
    cost = 5,
    blueprint_compat = true,

    discovered = false,
    unlocked = true,

    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_CENTERS.m_bda_diamond
    end,

    config = {
        enh = {
            G.P_CENTERS.m_stone,
            G.P_CENTERS.m_steel,
            G.P_CENTERS.m_gold,
            G.P_CENTERS.m_bda_diamond
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind then
            local eval = function() return G.GAME.current_round.hands_played == 0 end
            juice_card_until(card, eval, true)

        end

        if context.before and G.GAME.current_round.hands_played == 0 then
            local stone = {}
            for k, v in ipairs(context.full_hand) do
                if not v.debuff then
                    if v.config.center == G.P_CENTERS.m_stone then 
                        stone[#stone+1] = v
                    else
                        return true
                    end 
                end
            end
            if #stone ~= 0 then
                for k, v in ipairs(stone) do
                    local enh = card.ability.enh[pseudorandom('steve', 1, #card.ability.enh)]
                    v:set_ability(enh, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    })) 
                    return {
                        message = localize("k_bda_mine")
                    }
                end
            end
        end
    end
    
}

local content = {
    calendar,
    steve,
    teto
}
for _, v in ipairs(content) do
    SMODS.Joker(v)
end