SMODS.Rarity{
    key = "task",
    badge_colour = HEX("daad65"),
    text_colour = HEX("ffffff"),
    default_weight = 0
}

function remove_value(t, val)
    for i, v in ipairs(t) do
        if v == val then
            table.remove(t, i)
            return
        end
    end
end
function contains(t, val)
    for _, v in ipairs(t) do
        if v == val then return true end
    end
    return false
end
function roll_rarity()
    local roll = pseudorandom('task_rarity')
    local rarity = { 
        common = {0, .60},    --60
        rare = {.61, .85},    --25
        legendary = {.86, 1}  --15
    }
    for k,v in pairs(rarity) do
        if v[1] < roll and roll <= v[2] then
            return k
        end
    end
end
function missing_object(rar)
    local missing_object = {}
    local type = {'j', 'c'}
    missing_object["type"] = type[pseudorandom('missing_type', 1, 2)]

    if missing_object.type == 'j' then
        local keys = {}
        if rar == 'common' then
            for k,v in pairs(G.P_CENTERS) do
                if v.unlocked and v.rarity == 1 or v.rarity == 'common' then
                    keys[#keys + 1] = k
                end
            end
        end
        if rar == 'rare' then
            for k,v in pairs(G.P_CENTERS) do
                if v.unlocked and v.rarity == 2 or v.rarity == 'uncommon' then
                    keys[#keys + 1] = k
                end
            end
        end
        if rar == 'legendary' then
            for k,v in pairs(G.P_CENTERS) do
                if v.unlocked and v.rarity == 3 or v.rarity == 'rare' then
                    keys[#keys + 1] = k
                end
            end
        end
        for k,v in pairs(G.jokers.cards) do
            local k = v.config.center.key
            if contains(keys, k) then
                remove_value(keys, k)
            end
        end
        missing_object["key"] = keys[pseudorandom('missing_key', 1, #keys)]

    elseif missing_object.type == 'c' then
        local keys = {}
        if rar == 'common' then
            for k,v in pairs(G.P_CENTERS) do
                if (v.unlocked == nil or v.unlocked) and v.set == 'Tarot' then
                    keys[#keys + 1] = k
                end
            end
        end
        if rar == 'rare' then
            for k,v in pairs(G.P_CENTERS) do
                if (v.unlocked == nil or v.unlocked) and v.set == 'Planet' then
                    keys[#keys + 1] = k
                end
            end
        end
        if rar == 'legendary' then
            for k,v in pairs(G.P_CENTERS) do
                if (v.unlocked == nil or v.unlocked) and v.set == 'Spectral' then
                    keys[#keys + 1] = k
                end
            end
        end
        for k,v in pairs(G.consumeables.cards) do
            local k = v.config.center.key
            if contains(keys, k) then
                remove_value(keys, k)
            end
        end
        sendDebugMessage('колво ключей: '..#keys)
        missing_object["key"] = keys[pseudorandom('missing_key', 1, #keys)]
    end
    
    return missing_object
end
function reward(rar)
    local reward = {}
    local types_common = {
        d = {0, .45},     --45
        tp = {.46, .75},  --30
        s = {.76, .80},   --5
        k = {.81, 1},     --20
    }
    local types_rare = {
        d = {0, .35},     --35
        tp = {.36, .65},  --30
        s = {.66, .75},   --10
        k = {.76, 1},     --25
    }
    local types_legendary = {
        d = {0, .5},      --5
        tp = {.6, .15},   --10
        s = {.16, .40},   --25
        k = {.41, 1},     --60
    }
    local roll = pseudorandom('reward_type')
    if rar == 'common' then
        for k,v in pairs(types_common) do
            if not reward.type and v[1] < roll and roll <= v[2] then
                reward["type"] = k
            end
        end
    elseif rar == 'rare' then
        for k,v in pairs(types_rare) do
            if not reward.type and v[1] < roll and roll <= v[2] then
                reward["type"] = k
            end
        end
    elseif rar == 'legendary' then
        for k,v in pairs(types_legendary) do
            if not reward.type and v[1] < roll and roll <= v[2] then
                reward["type"] = k
            end
        end
    end
    if reward.type == 'd' then
        if rar == 'common' then reward.val = 10 end
        if rar == 'rare' then reward.val = 25 end
        if rar == 'legendary' then reward.val = 50 end
    elseif reward.type == 'tp' then
        local keys = {}
        for k,v in pairs(G.P_CENTERS) do
            if v.unlocked and v.set == 'Tarot' or v.set == 'Planet' then
                keys[#keys + 1] = k
            end
        end
        reward.val = keys[pseudorandom('missing_key', 1, #keys)]
    elseif reward.type == 's' then
        local keys = {}
        for k,v in pairs(G.P_CENTERS) do
            if v.unlocked and v.set == 'Spectral' then
                keys[#keys + 1] = k
            end
        end
        reward.val = keys[pseudorandom('missing_key', 1, #keys)]
    elseif reward.type == 'k' then
        local keys = {}
        for k,v in pairs(G.P_CENTERS) do
            if v.unlocked and v.set == 'packaging' then
                keys[#keys + 1] = k
            end
        end
        reward.val = keys[pseudorandom('missing_key', 1, #keys)]
    end

    return reward
end
function complete_task(card, rt, rv)
    if rt == 'd' then
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() 
            ease_dollars(rv)
            card:juice_up(0.3, 0.5)
        return true end }))
    else
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
            local set = ''
            for k,v in pairs(G.P_CENTERS) do
                if k == rv then
                    set = v.set
                end
            end 
            local rew = create_card(set, G.consumeables, nil, nil, nil, nil, rv)
            rew:set_edition('e_negative', true)
            rew:add_to_deck()
            G.consumeables:emplace(rew)
            card:juice_up(0.3, 0.5)
        return true end }))
    end
end

local task_missing = { --Missing
    key = "task_missing",
    rarity = "bda_task",
    atlas = "tasks",
    pos = {x = 0, y = 0},
    cost = 0,
    blueprint_compat = false, perishable_compat = false, eternal_compat = false, rental_compat = false,
    
    no_collection = true,
    discovered = true,
    unlocked = true,

    config = {
        rarity = nil,
        missing_object = nil,
        reward = nil,
        complete_status = false,

        card_limit = 1
    },

    calculate = function(self, card, context)

	end,

    update = function(self, card, dt)
        if card.ability.rarity == nil then
            card.ability.rarity = roll_rarity()
            sendDebugMessage(card.ability.rarity)
        end
        if card.ability.missing_object == nil then
            card.ability.missing_object = missing_object(card.ability.rarity)
            sendDebugMessage(card.ability.missing_object.type)
            sendDebugMessage(card.ability.missing_object.key)
        end
        if card.ability.reward == nil then
            card.ability.reward = reward(card.ability.rarity)
            sendDebugMessage(card.ability.reward.val)
        end
        if card.ability.missing_object.type == 'j' then
            for k,v in ipairs(G.jokers.cards) do
                if v.config.center.key == card.ability.missing_object.key then
                    if not card.ability.complete_status then
                        card.ability.complete_status = true
                        complete_task(card, card.ability.reward.type, card.ability.reward.val)
                        card:start_dissolve()
                        return {
                            message = localize('k_bda_task_complete')
                        }
                    end
                end
            end
        elseif card.ability.missing_object.type == 'c' then
            for k,v in ipairs(G.consumeables.cards) do
                if v.config.center.key == card.ability.missing_object.key then
                    if not card.ability.complete_status then
                        card.ability.complete_status = true
                        complete_task(card, card.ability.reward.type, card.ability.reward.val)
                        card:start_dissolve()
                        return {
                            message = localize('k_bda_task_complete')
                        }
                    end
                end
            end
        end
    end,

    loc_vars = function (self, info_queue, card)
        if card.ability.rarity ~= nil and card.ability.missing_object ~= nil and card.ability.reward ~= nil then
            info_queue[#info_queue+1] = G.P_CENTERS[card.ability.missing_object.key]
            if card.ability.reward.type ~= "d" then
                info_queue[#info_queue+1] = G.P_CENTERS[card.ability.reward.val]
            end
        end
    end
}

local task_wanted = { --Wanted
    key = "task_wanted",
    rarity = "bda_task",
    atlas = "tasks",
    pos = {x = 1, y = 0},
    cost = 0,
    blueprint_compat = false, perishable_compat = false, eternal_compat = false, rental_compat = false,
    
    no_collection = true,
    discovered = true,
    unlocked = true,

    config = {
        card_limit = 1
    },

    calculate = function(self, card, context)
	end,

    loc_vars = function (self, info_queue, card)
    end
}

local task_other = { --Other
    key = "task_other",
    rarity = "bda_task",
    atlas = "tasks",
    pos = {x = 2, y = 0},
    cost = 0,
    blueprint_compat = false, perishable_compat = false, eternal_compat = false, rental_compat = false,
    
    no_collection = true,
    discovered = true,
    unlocked = true,

    config = {
        card_limit = 1
    },

    calculate = function(self, card, context)
	end,

    loc_vars = function (self, info_queue, card)
    end
}

local content = {
    task_missing,
    task_wanted,
    task_other,
}
for _, v in ipairs(content) do
    SMODS.Joker(v)
end