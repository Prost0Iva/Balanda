SMODS.Keychain{
    key = "jimbo",
    pos = { x = 0, y = 0 },
    config = {
        extra = 2
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
                sendDebugMessage(tostring(card.keychains[self.key].ability.extra))
                sendDebugMessage(self.key)
            end
            return {
			    mult = card.keychains[self.key].ability.extra
		    }
        end
    end
}

SMODS.Keychain{
    key = "jolly",
    pos = { x = 1, y = 0 },
    config = {
        extra = 15
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
                sendDebugMessage(tostring(card.keychains[self.key].ability.extra))
                sendDebugMessage(self.key)
            end
            return {
			    chips = card.keychains[self.key].ability.extra
		    }
        end
    end
}

SMODS.Keychain{
    key = "perkeo",
    pos = { x = 2, y = 0 },
    config = {
        extra = 1.2
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
                sendDebugMessage(tostring(card.keychains[self.key].ability.extra))
                sendDebugMessage(self.key)
            end
            return {
			    xmult = card.keychains[self.key].ability.extra
		    }
        end
    end
}

SMODS.Keychain{
    key = "perkeo",
    pos = { x = 2, y = 0 },
    config = {
        extra = 1.2
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
            sendDebugMessage(tostring(card.keychains[self.key].ability.extra))
            sendDebugMessage(self.key)
            end
            return {
			    xmult = card.keychains[self.key].ability.extra
		    }
        end
    end
}

SMODS.Keychain{
    key = "miku",
    pos = { x = 3, y = 0 },
    config = {
        extra = 1.2
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
                sendDebugMessage(tostring(card.keychains[self.key].ability.extra))
                sendDebugMessage(self.key)
            end
            return {
			    xchips = card.keychains[self.key].ability.extra
		    }
        end
    end
}

SMODS.Keychain{
    key = "lucky_penny",
    pos = { x = 4, y = 0 },
    config = {
        extra = 1
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.keychains[self.key].ability.extra} }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card then
                sendDebugMessage(tostring(card.keychains[self.key].ability.extra))
                sendDebugMessage(self.key)
            end
            return {
			    dollars = card.keychains[self.key].ability.extra
		    }
        end
    end
}