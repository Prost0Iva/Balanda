SMODS.Rarity{ --добавление своей редкости
    key = "evo",
    badge_colour = HEX("9415e3"),
    text_colour = HEX("ffd18a"),
    default_weight = 0
}

local joker = { --Evo Joker
    key = "joker",
    rarity = "bda_evo",
    atlas = "evo",
    pos = {x = 0, y = 0},
    display_size = { w = 83, h = 125 },
    cost = 15,
    blueprint_compat = false,
    
    discovered = false,
    unlocked = false,
    check_for_unlock = function(self, args)
        if G.PROFILES[G.SETTINGS.profile].challenge_progress.completed["c_bda_evo_joker"] then
            unlock_card(self)
        end
    end,
    no_collection = true,

    config = {
        jokers = {},
        jokers_count = 0,
        evo_step = 0,
        evo_turn = 3,
        extra = {
            mult = 4,
            max_jokers = 8,
            xmult_per_joker = 1.5
        }
    },

    calculate = function(self, card, context)
        function contains(table, value) --функция, для проверки есть ли джокер в таблице
            for _, v in ipairs(table) do
                if v == value then
                    return true
                end
            end
            return false
        end

        --Добавляем всех не дебафнутых "Джокеров" игрока в таблицу, до основного подсчёта
        if context.before then 
            if card.ability.evo_step == card.ability.evo_turn then
                card.ability.jokers, card.ability.jokers_count = {}, 0
                for k, v in ipairs(G.jokers.cards) do
                    if (v.config.center.key == "j_joker" or v.config.center.key == "j_bda_joker") and not v.debuff then
                        if #card.ability.jokers < card.ability.extra.max_jokers then --не добавляем джокеров в таблицу, если их больше максимального ограничения
                            card.ability.jokers[#card.ability.jokers + 1] = v
                        end
                        card.ability.jokers_count = card.ability.jokers_count + 1 --продолжаем считать количество джокеров игрока
                    end
                end
            end
        end

        --Контекст основного подсчёта, в нём мы разграничиваем эффект обычного джокера и эволюции
		if context.joker_main then
            if card.ability.evo_step < card.ability.evo_turn then
                return {
				    mult = card.ability.extra.mult
			    }
            end
            if card.ability.evo_step == card.ability.evo_turn then
                return {
				    xmult = card.ability.extra.xmult_per_joker * card.ability.jokers_count
			    }
            end
		end

        --Контекст для тригера эффекта при подсчёте другого джокера
        if context.other_joker and card.ability.evo_step == card.ability.evo_turn then 
            if contains(card.ability.jokers, context.other_joker) then
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.4, func = function()
                    local joker = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_joker")
                    joker:set_edition('e_negative', true)
                    joker:add_sticker('perishable', true)
                    joker:add_to_deck()
                    joker.ability.extra_value = -3
                    joker:set_cost()
		            G.jokers:emplace(joker)
                return true end }))
                return {
                    message = localize('k_joker'),
                    colour = HEX("9415e3")
                }
            end
        end
        evo_check_status(card, context, self.pos.x)
	end,

    loc_vars = function (self, info_queue, card)
        if card.ability.evo_step < card.ability.evo_turn then
            return {
                key = self.key,
                vars = {card.ability.extra.mult, card.ability.evo_turn - card.ability.evo_step}
            }
        end
        if card.ability.evo_step == card.ability.evo_turn then
            info_queue[#info_queue+1] = G.P_CENTERS.j_joker
            local jokers_count = 0
                for k, v in ipairs(G.jokers.cards) do
                    if (v.config.center.key == "j_joker" or v.config.center.key == "j_bda_joker") and not v.debuff then
                        jokers_count = jokers_count + 1
                    end
                end
            return {
                key = self.key..'_evo',
                vars = {card.ability.extra.max_jokers, card.ability.extra.xmult_per_joker, card.ability.extra.xmult_per_joker * jokers_count}
            }
        end
    end
}

function evo_check_status(card, context, x) --Функция для подсчёта ходов эволюции
    --Контекст, после подсчёта, чтобы изменить текстуру джокера и поменять значение эволюции
    if context.final_scoring_step then
        card.ability.evo_step = card.ability.evo_step + 1
        if card.ability.evo_step > card.ability.evo_turn then
            card.ability.evo_step = 0
        end
        if card.ability.evo_step == 0 then
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                card:juice_up(0.8, 0.5)
                card.children.center:set_sprite_pos({x = x, y = 0})
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
        end
        if card.ability.evo_step == card.ability.evo_turn then
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                card:juice_up(0.8, 0.5)
                card.children.center:set_sprite_pos({x = x, y = 1})
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
            return {
                message = localize("k_bda_evo"),
                colour = HEX("9415e3")
            }
        end
    end
end

local content = {
    joker,
}
for _, v in ipairs(content) do
    SMODS.Joker(v)
end