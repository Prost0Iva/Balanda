return {
    misc = {
        dictionary = {
            k_bda_evo = "Эволюция",
            k_bda_mine = "Добыл",

            bda_sun = "Воскресенье",
            bda_mon = "Понедельник",
            bda_tue = "Вторник",
            bda_wed = "Среда",
            bda_thu = "Четверг",
            bda_fri = "Пятница",
            bda_sat = "Суббота"

        },
        challenge_names={
            c_bda_evo_joker = "Чел"
        },
        v_text={
            ch_c_bda_very_big_blinds={
                "{C:attention}Малый блайнд{} - {C:mult}2X база"
            },
            ch_c_bda_very_big_blinds_disc_1={
                "{C:attention}Большой блайнд{} - {C:mult}3X база"
            },
            ch_c_bda_very_big_blinds_disc_2={
                'Все босс блайнды - {C:attention}"Стена"{}'
            },
            ch_c_bda_very_big_blinds_disc_3={
                'Каждый {C:attention}4ый{} босс блайнд - {C:attention}"Фиолетовый сосуд"{}'
            },
            ch_c_bda_no_reroll={
                "Без перебросов лавки"
            },
            ch_c_bda_dementia_chance_up={
                'Эффекты {C:attention}"Амнезии"{} и {C:attention}"Деменции"{} усилены'
            }
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
                },
                unlock={
                    "Завершите испытание",
                    "{X:evo,C:white}Чел"
                }
            },
            j_bda_joker_evo = {
                name = "Джокер",
                text = {
                    'Создает {C:dark_edition}негативного временного "джокера"',
                    'при срабатывании "джокера"',
                    "{C:inactive}(макс. #1# раз)",
                    '{X:mult,C:white}X#2#{} множ. за каждого {C:attention}"джокера"{}',
                    "{C:inactive}(сейчас {X:mult,C:white}X#3#{C:inactive})"
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
                    "{C:inactive}(сейчас {X:mult,C:white}X#2#{C:inactive})"
                },
                unlock={
                    "{E:1,s:1.3}?????"
                }
            },
            j_bda_steve = {
                name = "Стив",
                text = {
                    "Если в {C:attention}первой руке{} раунда",
                    "только {C:attention}каменные карты{}",
                    "превращает их в {C:attention}стальные,",
                    "{C:attention}золотые и алмазные карты"
                }
            }
        },
        Voucher = {
            v_bda_amnesia = {
                name = "Амнезия",
                text = {
                    "{C:green}#1#%{} шанс добавить",
                    "случайного вашего джокера в магазин"
                }
            },
            v_bda_dementia = {
                name = "Деменция",
                text = {
                    "{C:green}#1#%{} шанс скопировать",
                    "случайного вашего джокера в магазин"
                }
            }
        },
        Spectral={
            c_bda_wild_shard={
                name="Осколок джокера",
                text={
                    "{X:evo,C:evo_text}Эволюционирует{} #1# выбранного",
                    "джокера",
                    "{C:inactive,s:0.8}Если выбранный джокер не имеет {X:evo,C:evo_text,s:0.8}эволюции",
                    "{C:inactive,s:0.8}или его {X:evo,C:evo_text,s:0.8}эволюция{C:inactive,s:0.8} не разблокирована,",
                    "{C:inactive,s:0.8}создает случайного джокера имеющего {X:evo,C:evo_text,s:0.8}эволюцию{}"
                },
                unlock={
                    "Завершите одно из",
                    "испытаний мода {X:evo,C:white}Balanda"
                }
            }
        },
        Tarot  = {
            c_bda_perseverance = {
                name = "Упорство",
                text = {
                    "Улучшает {C:attention}#1#{} выбранную",
                    "карту до: {C:attention}Алмазная карта",
                    "и преобразует в: {C:attention}Бубны"
                }
            }
        },
        Enhanced={
            m_bda_diamond = {
                name = "Алмазная карта",
                text = {
                    "{C:money}$#1#{} при использовании {C:red}сброса",
                    "{X:chips,C:white}X#2#{} фишек за каждые {C:money}$#3#",
                    "после разыгрывание джокеров,",
                    "пока эта карта остается в руке",
                    "{C:inactive}(сейчас {X:chips,C:white}X#4#{C:inactive})",
                    "{C:inactive}(макс. {X:chips,C:white}X#5#{C:inactive})"
                }
            }
        }
    }
}