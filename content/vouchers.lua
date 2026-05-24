SMODS.Atlas({key = 'vouchers', path = 'Vouchers.png', px = 71, py = 95})

SMODS.Voucher{ --Amnesia --R1UAI6C7
    key = "amnesia",
    cost = 10,
    atlas = "vouchers",
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = false,

    config = {
        extra = 20
    },

    calculate = function(self, card, context) 
        if context.starting_shop and G.jokers ~= nil then
            local rng = pseudorandom('amnesia')
            if rng < G.GAME.probabilities.normal / card.ability.extra then
                local shop_joker = G.shop_jokers.cards[pseudorandom('amnesia', 1, #G.shop_jokers.cards)] --берем рандомный слот в магазине
                local joker = G.jokers.cards[pseudorandom('amnesia', 1, #G.jokers.cards)] --берём рандомного джокера из инвентаря

                -- удаляем карту из магазина
                shop_joker:remove()

                -- копируем джокера и вставляем в магазин
                local card = create_card("Joker", context.area, nil, nil, nil, nil, joker.config.center.key)
                create_shop_card_ui(card, 'Joker', context.area) --эта мразь рисует ему ui магазина
                card:start_materialize()
                card:set_cost()
                G.shop_jokers:emplace(card)
            end
        end
    end,

    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal / card.ability.extra * 100
            }
        }
    end
    
}

SMODS.Voucher{ --Dementia
    key = "dementia",
    cost = 10,
    atlas = "vouchers",
    pos = {x = 0, y = 1},
    requires = { "v_bda_amnesia" },
    unlocked = false,
    discovered = false,

    config = {
        extra = 8
    },

    calculate = function(self, card, context) 
        if context.starting_shop and G.jokers ~= nil then
            local rng = pseudorandom('amnesia')
            if rng < G.GAME.probabilities.normal / card.ability.extra then
                local shop_joker = G.shop_jokers.cards[pseudorandom('amnesia', 1, #G.shop_jokers.cards)] --берем рандомный слот в магазине
                local joker = G.jokers.cards[pseudorandom('amnesia', 1, #G.jokers.cards)] --берём рандомного джокера из инвентаря

                -- удаляем карту из магазина
                shop_joker:remove()

                -- копируем джокера и вставляем в магазин
                local card = copy_card(joker)
                create_shop_card_ui(card, 'Joker', context.area) --эта мразь рисует ему ui магазина
                card:start_materialize()
                card:set_cost()
                G.shop_jokers:emplace(card)
            end
        end
    end,

    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                G.GAME.probabilities.normal / card.ability.extra * 100
            }
        }
    end
}