SMODS.Keychain{
    key = "jimbo",
    pos = { x = 0, y = 0 },
    config = {
        extra = 20
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
                card.keychains[self.key].ability.extra = card.keychains[self.key].ability.extra - 1
            end
            return {
			    mult = card.keychains[self.key].ability.extra
		    }
        end
    end
}

SMODS.Keychain{
    key = "jimbo1",
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
			    chips = 10
		    }
        end
    end
}

SMODS.Keychain{
    key = "jimbo2",
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
			    xmult = 1.2
		    }
        end
    end
}

SMODS.Keychain{
    key = "jimbo3",
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
			    xmult = 1.2
		    }
        end
    end
}

SMODS.Keychain{
    key = "jimbo4",
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
			    xmult = 1.2
		    }
        end
    end
}