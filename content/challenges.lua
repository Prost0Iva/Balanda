local evo_joker = { --Evo Joker
    key = "evo_joker",
    unlocked = function(self)
        return true
    end,

    rules = {
        custom = {
            {id = "bda_very_big_blinds"},
            {id = "bda_very_big_blinds_disc_1"},
            {id = "bda_very_big_blinds_disc_2"},
            {id = "bda_very_big_blinds_disc_3"},
            {id = "bda_no_reroll"},
            {id = "bda_dementia_chance_up"}
        },
        modifiers = {
        }
    },
    restrictions = {
        banned_cards = {
            {id = "j_chaos"},
            {id = "j_flash"},
            {id = "j_chicot"},
            {id = 'j_oops'},

            {id = "v_reroll_surplus"},
            {id = "v_reroll_glut"},
            {id = "v_directors_cut"},
            {id = "v_retcon"}
        },
        banned_tags = {
            {id = "tag_boss"},
            {id = "tag_d_six"}
            
        },
        banned_other = {}
    },
    jokers = {
        {id = "j_joker"},
        {id = "j_joker"},
        {id = "j_joker"},
        {id = "j_joker"},
        {id = "j_joker"}
    },
    vouchers = {
        {id = "v_bda_amnesia"},
        {id = "v_bda_dementia"}
    },
    deck = {
		type = "Challenge Deck",
	}
}

if SMODS.Mods["MinorArcana"] and SMODS.Mods["MinorArcana"].can_load then
    table.insert(evo_joker.restrictions.banned_cards, {id = "c_ma_acecup"})
    table.insert(evo_joker.restrictions.banned_cards, {id = "c_ma_kingcup"})
end

local content = {
    evo_joker,
}
for _, v in ipairs(content) do
    SMODS.Challenge(v)
end