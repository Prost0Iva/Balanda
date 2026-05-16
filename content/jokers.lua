SMODS.Atlas({key = 'bda_joker', path = 'Jokers.png', px = 71, py = 95})

SMODS.Joker{
    key = "calendar",
    rarity = 1,
    atlas = "bda_joker",
    pos = {x = 1, y = 0},
    cost = 5,
    blueprint_compat = true,

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

SMODS.Joker{
    key = "teto",
    rarity = 4,
    atlas = "bda_joker",
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,

    config = {
        date = {},
        extra = 1.5
    },

    calculate = function(self, card, context)
        if #card.ability.date == 0 then --Получаем дату при получении джокера
            local date = os.date("*t")
            card.ability.date = {day = date.day, month = date.month}
        end
        
        if context.joker_main and G.GAME.fools_count ~= 0 then
            if card.ability.date.day == 1 and card.ability.date.month == 4 then
                return {
                    xmult = card.ability.extra * G.GAME.fools_count * 31
                }
            else
                return {
                    xmult = card.ability.extra * G.GAME.fools_count
                }
            end
        end
	end,

    loc_vars = function (self, info_queue, card)
        local xmult = 1
        if G.GAME.fools_count ~= 0 then
            if card.ability.date.day == 1 and card.ability.date.month == 4 then
                xmult = card.ability.extra * G.GAME.fools_count * 31
            else
                xmult = card.ability.extra * G.GAME.fools_count
            end
        end

        info_queue[#info_queue+1] = G.P_CENTERS.c_fool
        
        return {
            vars = {
                card.ability.extra,
                xmult
            }
        }
    end
}