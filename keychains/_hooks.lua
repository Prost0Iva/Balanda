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

local bda_generate_UIBox = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    local full_UI_table = bda_generate_UIBox(self)
    
    if self.keychains then
        full_UI_table.badges[#full_UI_table.badges + 1] = 'bda_keychains'
        for k, v in pairs(self.keychains) do
            if v and SMODS.Keychains[k] then
                local keychain = SMODS.Keychains[k]
                local new_info, vars = {}, {}

                new_info.name = G.localization.descriptions.Keychains[k] and G.localization.descriptions.Keychains[k].name or k
                if keychain.loc_vars and type(keychain.loc_vars) == 'function' then
                    local info_queue = {}
                    local loc_vars_result = keychain:loc_vars(info_queue, self)
                    vars = loc_vars_result and loc_vars_result.vars or {}
                    -- добавляем всё что loc_vars положил в info_queue
                    for _, v in ipairs(info_queue) do
                        generate_card_ui(v, full_UI_table)
                    end
                end

                localize{
                    type = 'descriptions',
                    key = k,
                    set = 'Keychains',
                    nodes = new_info,
                    vars = vars
                }
                full_UI_table.info[#full_UI_table.info + 1] = new_info
            end
        end
    end
    
    return full_UI_table
end

local bda_card_save = Card.save
function Card:save()
    local cardTable = bda_card_save(self)

    cardTable.keychains = self.keychains

    return cardTable
end

local bda_load_card = Card.load
function Card:load(cardTable, other_card)
    bda_load_card(self, cardTable, other_card)

    self.keychains = cardTable.keychains

end