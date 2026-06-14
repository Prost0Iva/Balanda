SMODS.Keychain{
    key = "jimbo",
    pos = { x = 0, y = 0 },
    config = {
        mult = 2
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.mult} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
			    self.config.mult
		    }
        end
    end
}