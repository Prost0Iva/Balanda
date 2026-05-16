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
            chips = 100,
            mult = 10,
            xmult = 1.5,
            dollars = 5,
            hands = 1,
            discards = 1

        }
    },

    calculate = function(self, card, context)
        if card.ability.wday == 0 then
            local date = os.date("*t")
            card.ability.wday = date.wday

            if card.ability.wday == 6 then --Пятница размер руки
                card.ability.h_size = 1
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
        extra = {}
    },

    calculate = function(self, card, context)
        
	end
}