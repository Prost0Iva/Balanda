---------------------------------------------------------------------------------------------------------
--Привет, я Iva, это мой мод - Balanda
--Мод добавляет в игру новых джокеров, механики и тд
--Это сообщение для тех, кто хочет начать писать моды для Балатро,
--так как в момент написания этого комментария, я сам с нуля изучаю эту стизю,
--надеюсь изучение работы моего мода и оставленные далее мной комментарии, помогут вам быстрее освоиться!
--Удачи, йей 
--P.S. Добавлять подробные комментарии буду, только наиболее интересным вещам,
--остальное вам легче будет изучить самим в документации 
--самого smods (https://github.com/Steamodded/smods/wiki/API-Documentation)
---------------------------------------------------------------------------------------------------------

local mod_path = SMODS.current_mod.path
local lib = NFS.getDirectoryItems(mod_path .. "lib")
local content = NFS.getDirectoryItems(mod_path .. "content")
local files = {
    lib = lib,
    content = content
}
for k, v in pairs(files) do
    for _, f in ipairs(v) do
        sendDebugMessage(k .. "/" .. f)
        SMODS.load_file(k .. "/" .. f)()
    end
end

SMODS.Rarity{ --добавление своей редкости
    key = "evo",
    badge_colour = HEX("9415e3"),
    text_colour = HEX("ffd18a"),
    default_weight = 0
}