local diamond = {
    key = "diamond",
    atlas = "enhancements",
    pos = { x = 0, y = 0 },

    config = {
        extra = {
            x_per_dol = 1.5,
            dol_req = 25,
            dollars = 2
        },
        h_x_chips
    },

    loc_vars = function (self, info_queue, card)
        return {
            vars = {card.ability.h_x_chips}
        }
    end,

    calculate = function(self, card, context)
        if G.GAME.dollars % card.ability.extra.dol_req ~= 0 then
            card.ability.h_x_chips = G.GAME.dollars % card.ability.extra.dol_req * card.ability.extra.x_per_dol
        else
            card.ability.h_x_chips = 1
        end
    end,
}

local content = {
    diamond,
}
for _, v in ipairs(content) do
    SMODS.Enhancement(v)
end