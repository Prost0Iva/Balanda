SMODS.Rarity{ --добавление своей редкости
    key = "task",
    badge_colour = HEX("daad65"),
    text_colour = HEX("ffffff"),
    default_weight = 0
}

local test_task = { --test_task
    key = "test_task",
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

local content = {
    test_task,
}
for _, v in ipairs(content) do
    SMODS.Joker(v)
end