local bda_lc = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		bda_lc()
	end
	G.ARGS.LOC_COLOURS.evo = HEX('9415e3')
	G.ARGS.LOC_COLOURS.evo_text = HEX('ffd18a')
	
	return bda_lc(_c, _default)
end

local bda_igo = Game.init_game_object
function Game:init_game_object() --Хук на добавление своих переменных использующихся в партии
	local g = bda_igo(self)

    g.bda_fools_count = 0
    g.bda_evo_list = {
        j_joker = "j_bda_joker",
        j_egg = "j_golden"
    }
    
    return g
end

local bda_use_consumeable = Card.use_consumeable
function Card:use_consumeable(area, copier)
	
    if self.ability.name == 'The Fool' then
        G.GAME.bda_fools_count = G.GAME.bda_fools_count + 1
    end
    
	bda_use_consumeable(self, area, copier)
end

local bda_upd = Game.update
function Game:update(dt)

    if G.GAME.modifiers.bda_very_big_blinds then
        if G.GAME.round_resets.ante % 4 == 0 then
            G.GAME.round_resets.blind_choices.Boss = 'bl_final_vessel'
        else
            G.GAME.round_resets.blind_choices.Boss = 'bl_wall'
        end
        G.P_BLINDS.bl_small.mult = 2
        G.P_BLINDS.bl_big.mult = 3
    else
        G.P_BLINDS.bl_small.mult = 1
        G.P_BLINDS.bl_big.mult = 1.5
    end

    bda_upd(self, dt)
end

local bda_can_reroll = G.FUNCS.can_reroll
function G.FUNCS.can_reroll(e)

	if G.GAME.modifiers.bda_no_reroll then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		return bda_can_reroll(e)
	end

end