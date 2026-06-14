-- Main
G.shared_keychains = {}
SMODS.Keychains = {}
SMODS.Keychain = SMODS.GameObject:extend {
    obj_table = SMODS.Keychains,
    class_prefix = 'kch',
    obj_buffer = {},
    required_params = {'key'},
    dependencies = {'Balanda'},
    register = function(self)
            if self.registered then
                sendWarnMessage(('Detected duplicate register call on object %s'):format(self.key), self.set)
                return
            end
            self.name = self.name or self.key
            SMODS.Keychain.super.register(self)
        end,
    pre_inject_class = function(self)
            G.shared_keychains = G.shared_keychains or {}
        end,
    inject = function(self)
            self.keychain_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS[self.atlas], self.pos)
            G.shared_keychains[self.key] = self.keychain_sprite
            G.BADGE_COL = G.BADGE_COL or {}
            G.BADGE_COL['bda_keychains'] = self.badge_colour
        end,
    process_loc_text = function(self)
            SMODS.process_loc_text(G.localization.descriptions.Keychains, self.key, self.loc_txt)
        end,
    set = 'Keychain',
    atlas = 'bda_keychains',
    pos = {x = 0, y = 0},
    badge_colour = HEX('b2b5c2'),
    default_compat = true,
    sets = {Joker = true},
    needs_enable_flag = true,
    apply = function(self, card, val)
        card.keychains = card.keychains or {}
        card.keychains[self.key] = val
    end,
}

SMODS.DrawStep {
    key = 'keychains',
    order = 35,
    func = function(self, layer)
        if self.keychains and next(self.keychains) then
            for k, v in pairs(self.keychains) do
                G.shared_keychains[k].role.draw_major = self
                G.shared_keychains[k]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 1.014, 2.299)
            end
        end
    end
}

function Card:set_keychain(_keychain)
    SMODS.Keychains[_keychain]:apply(self, true)
    SMODS.enh_cache:write(self, nil)
end

function Card:calculate_keychain(context, key)
    if not self.keychains then return end
    local keychain = SMODS.Keychains[key]
    if self.keychains[key] and type(keychain.calculate) == 'function' then
        local o = keychain:calculate(self, context)
        if o then
            if not o.card then o.card = self end
            return o
        end
    end
end

-- UI
SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button({
            button = 'other_collection_keychains',
            label = {localize('b_keychains')},
            minw = 5,
            id = 'other_collection_keychains'
        })
    }
end

G.FUNCS.other_collection_keychains = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_other_collection_keychains()
    }
end

create_UIBox_other_collection_keychains = function()
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