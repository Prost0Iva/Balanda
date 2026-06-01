local diamond = {
    key = "diamond",
    atlas = "enhancements",
    pos = { x = 0, y = 0 },

    config = {
        extra = {
            x_per_dol = 0.1,
            dol_req = 5,
            dollars = 1,
            max = 3
        },
    },

    loc_vars = function (self, info_queue, card)
        return {
            vars = {card.ability.extra.dollars, card.ability.extra.x_per_dol, card.ability.extra.dol_req ,math.min((1 + math.floor(G.GAME.dollars / card.ability.extra.dol_req) * card.ability.extra.x_per_dol), card.ability.extra.max), card.ability.extra.max}
        }
    end,

    calculate = function(self, card, context)
        if context.pre_discard then
            return { dollars =  card.ability.extra.dollars }
        end
        if context.final_scoring_step and context.cardarea == G.hand then
            return { xchips = math.min((1 + math.floor(G.GAME.dollars / card.ability.extra.dol_req) * card.ability.extra.x_per_dol), card.ability.extra.max) }
        end
        
    end,
}

local content = {
    diamond,
}
for _, v in ipairs(content) do
    SMODS.Enhancement(v)
end