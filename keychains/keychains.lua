SMODS.Keychain{
    key = "jimbo",
    badge_colour = HEX('FF00FF'),
    pos = { x = 0, y = 0 },
    config = {},
    calculate = function(self, card, context)
        if context.joker_main then
            return {
			    mult = 2
		    }
        end
    end
}