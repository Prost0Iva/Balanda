return {
    misc = {
        dictionary = {
            k_bda_evo = "Evolution",

            bda_sun = "Sunday",
            bda_mon = "Monday",
            bda_tue = "Tuesday",
            bda_wed = "Wednesday",
            bda_thu = "Thursday",
            bda_fri = "Friday",
            bda_sat = "Saturday"

        },
        challenge_names={
            c_bda_evo_joker = "Chell"
        },
        v_text={
            ch_c_bda_very_big_blinds={
                "{C:attention}Small Blind{} - {C:mult}2X Base"
            },
            ch_c_bda_very_big_blinds_disc_1={
                "{C:attention}Big Blind{} - {C:mult}3X Base"
            },
            ch_c_bda_very_big_blinds_disc_2={
                'All Boss Blind is {C:attention}"The Wall"{}'
            },
            ch_c_bda_very_big_blinds_disc_3={
                'Every {C:attention}4th{} Boss Blind is {C:attention}"Violet Vessel"{}'
            },
            ch_c_bda_no_reroll={
                "No shop rerolls"
            },
            ch_c_bda_dementia_chance_up={
                'Effects of {C:attention}"Amnesia"{} and {C:attention}"Dementia"{} are Increased'
            }
        }
    },
    descriptions = {
        Other = {
            bda_mon_eff = {
                name = "Monday",
                text = {
                    "{C:chips}+#1#{} Chips"
                }
            },
            bda_tue_eff = {
                name = "Tuesday",
                text = {
                    "{C:mult}+#1#{} Mult"
                }
            },
            bda_wed_eff = {
                name = "Wednesday",
                text = {
                    "{X:mult,C:white}X#1#{} Mult"
                }
            },
            bda_thu_eff = {
                name = "Thursday",
                text = {
                    "Earn {C:money}$#1#{} at end of round"
                }
            },
            bda_fri_eff = {
                name = "Friday",
                text = {
                    "{C:attention}+#1#{} Hand Size"
                }
            },
            bda_sat_eff = {
                name = "Saturday",
                text = {
                    "{C:blue}+#1#{} Hands"
                }
            },
            bda_sun_eff = {
                name = "Sunday",
                text = {
                    "{C:red}+#1#{} Discards"
                }
            }
        },
        Joker = {

            --Evo Jokers

            j_bda_joker = {
                name = "Joker",
                text = {
                    "{C:red,s:1.1}+#1#{} Mult",
                    "{C:inactive}(Evolves after #2# triggers)"
                },
                unlock={
                    "Complete {X:evo,C:white}Chell",
                    "challenge"
                }
            },
            j_bda_joker_evo = {
                name = "Joker",
                text = {
                    'Creates a {C:dark_edition}Negative Perishable "Joker"',
                    'when the "Joker" is triggered',
                    "{C:inactive}(Max #1# times)",
                    '{X:mult,C:white}X#2#{} Mult per {C:attention}"Joker"{}',
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive})",
                }
            },

            --Default Jokers

            j_bda_calendar = {
                name = "Calendar",
                text = {
                    "Effect depends on",
                    "the day of the week"
                }
            },
            j_bda_teto = {
                name = "Teto",
                text = {
                    "{X:mult,C:white}X#1#{} Mult per {C:purple}The Fool{}",
                    "used this run",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})",
                },
                unlock={
                    "{E:1,s:1.3}?????",
                }
            }
        },
        Voucher = {
            v_bda_amnesia = {
                name = "Amnesia",
                text = {
                    "{C:green}#1#%{} chance to add",
                    "your random joker to shop"
                }
            },
            v_bda_dementia = {
                name = "Dementia",
                text = {
                    "{C:green}#1#%{} chance to copy",
                    "your random joker into shop"
                }
            }
        },
        Spectral={
            c_bda_wild_shard={
                name="Wild Shard",
                text={
                    "{X:evo,C:evo_text}Evolves{} #1# selected",
                    "Joker",
                    "{C:inactive,s:0.8}If selected Joker doesn't have an {X:evo,C:evo_text,s:0.8}Evo",
                    "{C:inactive,s:0.8}Or his {X:evo,C:evo_text,s:0.8}Evo{C:inactive,s:0.8} is not unlocked",
                    "{C:inactive,s:0.8}Creates a random Joker that has an {X:evo,C:evo_text,s:0.8}Evo{}"
                },
                unlock={
                    "Complete one of",
                    "{X:evo,C:white}Balanda's{} challenges"
                }
            }
        }
    }
}
