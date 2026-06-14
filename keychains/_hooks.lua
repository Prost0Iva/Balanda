--local bda_card_init = Card.init
--function Card:init(X, Y, W, H, card, center, params)
--    self.keychains = {}
--
--    bda_card_init(self, X, Y, W, H, card, center, params)
--end

local bda_eval_card = eval_card
function eval_card(card, context)
    local ret, post = bda_eval_card(card, context)

    if card.keychains and (context.cardarea == G.jokers or context.card == G.consumeables or context.repetition_only) then
        for _,k in ipairs(SMODS.Keychain.obj_buffer) do
            local v = SMODS.Keychains[k]
            local keychain = card:calculate_keychain(context, k)
            if keychain then
                ret[v] = keychain
            end
        end
    end

    return ret, post
end

local bda_trigger_effects = SMODS.trigger_effects
SMODS.trigger_effects = function(effects, card)
    local ret = bda_trigger_effects(effects, card)

    for _, effect_table in ipairs(effects) do
        for _, k in ipairs(SMODS.Keychain.obj_buffer) do
            local v = SMODS.Keychains[k]
            SMODS.calculate_effect_table_key(effect_table, v, card, ret)
        end
    end

    return ret
end