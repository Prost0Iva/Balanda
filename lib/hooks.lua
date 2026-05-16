local bda_igo = Game.init_game_object
function Game:init_game_object() --Хук на добавление своих переменных использующихся в партии
	local g = bda_igo(self)

    g.fools_count = 0
    
    return g
end

local bda_use_consumeable = Card.use_consumeable
function Card:use_consumeable(area, copier)
	
    if self.ability.name == 'The Fool' then
        G.GAME.fools_count = G.GAME.fools_count + 1
    end
    
	bda_use_consumeable(self, area, copier)
end