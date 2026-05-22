return {
    misc = {
        dictionary = {
            k_bda_evo = "Эволюция",

            bda_sun = "Воскресенье",
            bda_mon = "Понедельник",
            bda_tue = "Вторник",
            bda_wed = "Среда",
            bda_thu = "Четверг",
            bda_fri = "Пятница",
            bda_sat = "Суббота"
        }
    },
    descriptions = {
        Other = {
            bda_mon_eff = {
                name = "Понедельник",
                text = {
                    "{C:chips}+#1#{} шт. фишек"
                }
            },
            bda_tue_eff = {
                name = "Вторник",
                text = {
                    "{C:mult}+#1#{} множ."
                }
            },
            bda_wed_eff = {
                name = "Среда",
                text = {
                    "{X:mult,C:white}X#1#{} множ."
                }
            },
            bda_thu_eff = {
                name = "Четверг",
                text = {
                    "Получите {C:money}$#1#{} в конце раунда"
                }
            },
            bda_fri_eff = {
                name = "Пятница",
                text = {
                    "{C:attention}+#1#{} размер руки"
                }
            },
            bda_sat_eff = {
                name = "Суббота",
                text = {
                    "{C:blue}+#1#{} рука"
                }
            },
            bda_sun_eff = {
                name = "Воскресенье",
                text = {
                    "{C:red}+#1#{} сброс"
                }
            }
        },
        Joker = {

            --Evo Jokers

            j_bda_joker = {
                name = "Джокер",
                text = {
                    "{C:red,s:1.1}+#1#{} множ.",
                    "{C:inactive}(Эволюционирует через #2# срабатывания)"
                }
            },
            j_bda_joker_evo = {
                name = "Джокер",
                text = {
                    'Создает {C:dark_edition}негативного временного "джокера"',
                    'при срабатывании "джокера"',
                    "{C:inactive}(макс. #1# раз)",
                    '{X:mult,C:white}X#2#{} множ. за каждого {C:attention}"джокера"{}',
                    "{C:inactive}(сейчас {X:mult,C:white}X#3#{C:inactive})",
                }
            },

            --Default Jokers

            j_bda_calendar = {
                name = "Календарь",
                text = {
                    "Эффект зависит",
                    "от дня недели"
                }
            },
            j_bda_teto = {
                name = "Тето",
                text = {
                    "{X:mult,C:white}X#1#{} множ. за каджого",
                    "использованного {C:purple}Дурака{}",
                    "{C:inactive}(сейчас {X:mult,C:white}X#2#{C:inactive})",
                }
            }
        }
    }
}