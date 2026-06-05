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

SMODS.Sound({
    key = "chomp",
	path = "chomp.ogg"
})