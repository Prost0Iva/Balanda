---------------------------------------------------------------------------------------------------------
--Всеееееем привет дорогие друзья, с вами снова я, Кейн, и это уже 255 часть наших обзоров модов!
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

--SMODS.Sound({
--	key = "music_badapple",
--	path = "music_badapple.ogg",
--	sync = false,
--	pitch = 1,
--	select_music_track = function()
--		return next(find_joker("bda_BadApple"))
--			--and Cryptid_config.Cryptid
--			--and Cryptid_config.Cryptid.jimball_music
--			-- Lowering priority for edition Jimballs later
--			--and 200
--	end,
--})
--function find_joker(name, non_debuff)
--  local jokers = {}
--  if not G.jokers or not G.jokers.cards then return {} end
--  for k, v in pairs(G.jokers.cards) do
--    if v and type(v) == 'table' and v.ability.name == name and (non_debuff or not v.debuff) then
--      table.insert(jokers, v)
--    end
--  end
--  for k, v in pairs(G.consumeables.cards) do
--    if v and type(v) == 'table' and v.ability.name == name and (non_debuff or not v.debuff) then
--      table.insert(jokers, v)
--    end
--  end
--  return jokers
--end