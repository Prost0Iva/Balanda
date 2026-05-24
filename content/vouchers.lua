SMODS.Atlas({key = 'vouchers', path = 'Vouchers.png', px = 71, py = 95})

SMODS.Voucher{ --Amnesia
    key = "amnesia",
    cost = 10,
    atlas = "vouchers",
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = false,

    config = {
        extra = 2
    },

    calculate = function(self, card, context) 
        if context.starting_shop and G.jokers ~= nil then
            local rng = pseudorandom('amnesia')
            if rng < G.GAME.probabilities.normal / card.ability.extra then
                sendDebugMessage('Сработало')
                for i = 1, (#G.jokers.cards) do
                    G.shop_jokers[math.floor(pseudorandom('amnesia', 1, #G.shop_jokers))] = G.jokers.cards[math.floor(pseudorandom('amnesia', 1, #G.jokers.cards))]
                end
            end
        end
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
}