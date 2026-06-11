---------------------------------------------------------------------------------------------------------
--Всеееееем привет дорогие друзья, с вами снова я, Кейн, и это уже 255 часть наших обзоров модов!
---------------------------------------------------------------------------------------------------------

local mod_path = SMODS.current_mod.path
local lib = NFS.getDirectoryItems(mod_path .. "lib")
local content = NFS.getDirectoryItems(mod_path .. "content")
local keychains = NFS.getDirectoryItems(mod_path .. "keychains")
local files = {
    lib = lib,
    content = content,
    keychains = keychains
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