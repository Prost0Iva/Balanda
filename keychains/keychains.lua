G.shared_keychains = G.shared_keychains or {}
SMODS.Keychains = {}
    SMODS.Keychain = SMODS.GameObject:extend {
        obj_table = SMODS.Keychains,
        obj_buffer = {},
        set = 'Keychain',
        required_params = {
            'key',
        },
        rate = 0.0,
        atlas = 'bda_keychains',
        pos = { x = 0, y = 0 },
        badge_colour = HEX('FFFFFF'),
        default_compat = true,
        compat_exceptions = {},
        sets = { Joker = true },
        needs_enable_flag = true,
        process_loc_text = function(self)
            SMODS.process_loc_text(G.localization.descriptions.Other, self.key, self.loc_txt)
            SMODS.process_loc_text(G.localization.misc.labels, self.key, self.loc_txt, 'label')
        end,
        register = function(self)
            if self.registered then
                sendWarnMessage(('Detected duplicate register call on object %s'):format(self.key), self.set)
                return
            end
            SMODS.Keychain.super.register(self)
            self.order = #self.obj_buffer
        end,
        inject = function(self)
            self.keychain_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS[self.atlas], self.pos)
            G.shared_keychains[self.key] = self.keychain_sprite
        end,
        -- relocating sticker checks to here, so if the sticker has different checks than default
        -- they can be handled without hooking/injecting into create_card
        -- or handling it in apply
        -- TODO: rename
        --should_apply = function(self, card, center, area, bypass_roll)
        --    if
        --        ( not self.sets or self.sets[center.set or {}]) and
        --        (
        --            center[self.key..'_compat'] or -- explicit marker
        --            (
        --                center[self.key..'_compat'] == nil and
        --                ((self.default_compat and not self.compat_exceptions[center.key]) or -- default yes with no exception
        --                (not self.default_compat and self.compat_exceptions[center.key]))
        --            ) -- default no with exception
        --        ) and
        --        (not self.needs_enable_flag or G.GAME.modifiers['enable_'..self.key])
        --    then
        --        self.last_roll = pseudorandom((area == G.pack_cards and 'packssj' or 'shopssj')..self.key..G.GAME.round_resets.ante)
        --        return (bypass_roll ~= nil) and bypass_roll or self.last_roll > (1-self.rate)
        --    end
        --end,
        apply = function(self, card, val)
            card.ability[self.key] = val
        end
    }

    SMODS.Keychain{
        key = "jimbo",
        badge_colour = HEX('c75985'),
        prefix_config = {key = false},
        pos = { x = 0, y = 0 },
        hide_badge = true,
        order = 1,
        inject = function(self)
            SMODS.Keychain.inject(self)
            --G.shared_sticker_eternal = self.sticker_sprite
        end,
    }

SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
            button = 'your_collection_keychains',  -- имя функции которая откроет коллекцию
            label = {localize('b_keychains')},      -- текст кнопки
            minw = 5,
            id = 'your_collection_keychains'
        })
    }
end

G.FUNCS.your_collection_keychains = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_your_collection_keychains()
    }
end

create_UIBox_your_collection_keychains = function()
    return SMODS.card_collection_UIBox(SMODS.Keychains, {5,5}, {
        snap_back = true,
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.03,
        back_func = 'your_collection_other_gameobjects',
        modify_card = function(card, center)
            center:apply(card, true)
        end,
    })
end 

local card_draw_ref = Card.draw
function Card:draw(layer)

    card_draw_ref(self, layer)
    
    if self.ability.jimbo then
        G.shared_keychains["jimbo"].role.draw_major = self
        G.shared_keychains["jimbo"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 1.014, 2.446)
    end
end