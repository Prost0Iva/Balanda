local vouchers = {key = 'vouchers', path = 'Vouchers.png', px = 71, py = 95}
local jokers = {key = 'jokers', path = 'Jokers.png', px = 71, py = 95}
local evo = {key = 'evo', path = 'Evo.png', px = 83, py = 125}
local wild_shard = {key = 'wild_shard', path = 'WildShard.png', atlas_table = 'ANIMATION_ATLAS', frames = 10, fps = 6, px = 71, py = 95}
local enhancements = {key = 'enhancements', path = 'Enhancements.png', px = 71, py = 95}
local consumables = {key = 'consumables', path = 'Consumables.png', px = 71, py = 95}
local bad_apple = {key = 'bad_apple', path = 'BadApple.png', atlas_table = 'ANIMATION_ATLAS', frames = 212, fps = 30, px = 71, py = 95}
local stickers = {key = 'stickers', path = 'Stickers.png', px = 71, py = 95}

local content = {
    vouchers,
    jokers,
    evo,
    wild_shard,
    enhancements,
    consumables,
    bad_apple,
    stickers
}

for _, v in ipairs(content) do
    SMODS.Atlas(v)
end