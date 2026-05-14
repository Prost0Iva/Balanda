SMODS.Atlas({key = 'bda_evo', path = 'Evo.png', px = 83, py = 125})

SMODS.Joker{
    key = "evo_joker",
    rarity = "bda_evo",
    atlas = "bda_evo",
    pos = {x = 0, y = 0},
    display_size = { w = 83, h = 125 },
    cost = 15,
    blueprint_compat = true,

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
        local function contains(table, value) --функция, для проверки есть ли джокер в таблице
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
                    if (v.config.center.key == "j_joker" or v.config.center.key == "j_bda_evo_joker") and not v.debuff then
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
                    card.children.center:set_sprite_pos({x = 0, y = 0})
                return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
            end
            if card.ability.evo_step == card.ability.evo_turn then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    card:juice_up(0.8, 0.5)
                    card.children.center:set_sprite_pos({x = 1, y = 0})
                return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() card:flip() return true end }))
                return {
                    message = localize("k_bda_evo"),
                    colour = HEX("9415e3")
                }
            end
        end
	end
}