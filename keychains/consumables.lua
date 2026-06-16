SMODS.ConsumableType{
    key = 'packaging',
    primary_colour = HEX('63646e'),
    secondary_colour = HEX('b2b5c2'),
    collection_rows = {5, 5},
    shop_rate = 0.0,
}
SMODS.UndiscoveredSprite{
    key = 'packaging',
    atlas = 'packaging',
    pos = {x = 1, y = 0}
}

local jimbo = {
    set = 'packaging',
    key = "jimbo",
    unlocked = true,
    discovered = false,

    atlas = 'packaging',
	pos = { x = 2, y = 0 },

    config = {},

    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue+1] = SMODS.Keychains['kch_bda_jimbo']
    end,

    use = function (self, card, area, copier)
        G.jokers.highlighted[1]:set_keychain('kch_bda_jimbo')
    end, 

    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].keychains or not G.jokers.highlighted[1].keychains["kch_bda_"..self.key]) then
            return true
        end
    end

}
local jolly = {
    set = 'packaging',
    key = "jolly",
    unlocked = true,
    discovered = false,

    atlas = 'packaging',
	pos = { x = 3, y = 0 },

    config = {},

    loc_vars = function(self, info_queue, card)
    end,

    use = function (self, card, area, copier)
        G.jokers.highlighted[1]:set_keychain('kch_bda_jolly')
    end, 

    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].keychains or not G.jokers.highlighted[1].keychains["kch_bda_"..self.key]) then
            return true
        end
    end

}
local perkeo = {
    set = 'packaging',
    key = "perkeo",
    unlocked = true,
    discovered = false,

    atlas = 'packaging',
	pos = { x = 4, y = 0 },

    config = {},

    loc_vars = function(self, info_queue, card)
    end,

    use = function (self, card, area, copier)
        G.jokers.highlighted[1]:set_keychain('kch_bda_perkeo')
    end, 

    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].keychains or not G.jokers.highlighted[1].keychains["kch_bda_"..self.key]) then
            return true
        end
    end

}
local miku = {
    set = 'packaging',
    key = "miku",
    unlocked = true,
    discovered = false,

    atlas = 'packaging',
	pos = { x = 5, y = 0 },

    config = {},

    loc_vars = function(self, info_queue, card)
    end,

    use = function (self, card, area, copier)
        G.jokers.highlighted[1]:set_keychain('kch_bda_miku')
    end, 

    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].keychains or not G.jokers.highlighted[1].keychains["kch_bda_"..self.key]) then
            return true
        end
    end

}
local lucky_penny = {
    set = 'packaging',
    key = "lucky_penny",
    unlocked = true,
    discovered = false,

    atlas = 'packaging',
	pos = { x = 6, y = 0 },

    config = {},

    loc_vars = function(self, info_queue, card)
    end,

    use = function (self, card, area, copier)
        G.jokers.highlighted[1]:set_keychain('kch_bda_lucky_penny')
    end, 

    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].keychains or not G.jokers.highlighted[1].keychains["kch_bda_"..self.key]) then
            return true
        end
    end

}
local tamagotchi = {
    set = 'packaging',
    key = "tamagotchi",
    unlocked = true,
    discovered = false,

    atlas = 'packaging',
	pos = { x = 0, y = 1 },

    config = {},

    loc_vars = function(self, info_queue, card)
    end,

    use = function (self, card, area, copier)
        G.jokers.highlighted[1]:set_keychain('kch_bda_tamagotchi')
    end, 

    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted == 1 and (not G.jokers.highlighted[1].keychains or not G.jokers.highlighted[1].keychains["kch_bda_"..self.key]) then
            return true
        end
    end

}

local content = {
    jimbo,
    jolly,
    perkeo,
    miku,
    lucky_penny,
    tamagotchi,
}
for _, v in ipairs(content) do
    SMODS.Consumable(v)
end