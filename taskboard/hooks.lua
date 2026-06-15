local bda_igo = Game.init_game_object
function Game:init_game_object() --Хук на добавление своих переменных использующихся в партии
	local g = bda_igo(self)

    g.bda_taskboard = {
        tasks_max = 3
    }

    return g
end