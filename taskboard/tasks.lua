SMODS.Rarity{
    key = "task",
    badge_colour = HEX("daad65"),
    text_colour = HEX("ffffff"),
    default_weight = 0
}

function task_rarity()
    return pseudorandom('task_rarity', 1, 3)
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
    },

    calculate = function(self, card, context)
	end,

    loc_vars = function (self, info_queue, card)
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