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
                }
            }
        }
    }
}
