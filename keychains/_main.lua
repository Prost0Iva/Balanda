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
            self.order = #self.obj_buffer
        end,
    pre_inject_class = function(self)
            G.shared_keychains = G.shared_keychains or {}
        end,
    inject = function(self)
            self.keychain_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS[self.atlas], self.pos)
            G.shared_keychains[self.key] = self.keychain_sprite
            G.BADGE_COL = G.BADGE_COL or {}
            G.BADGE_COL['bda_keychains'] = self.badge_colour
            G.keychains_limit = G.keychains_limit or 3
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
    apply = function(self, card, val, silent)
        card.keychains = card.keychains or {}
        local kch = 0
        for _ in pairs(card.keychains) do kch = kch + 1 end
        if (card.local_keychains_limit == nil and kch >= G.keychains_limit) or (card.local_keychains_limit ~= nil and kch >= card.local_keychains_limit) then
            local first_key = next(card.keychains)
            if first_key then
                card.keychains[first_key] = nil
            end
            sendWarnMessage('Ремувнулось')
        end
        card.keychains[self.key] = {
            ref = self,         -- ссылка на объект кейчейна
            ability = copy_table(self.config) -- данные
        }
    end,
}

SMODS.DrawStep {
    key = 'keychains',
    order = 35,
    func = function(self, layer)
        if self.keychains and next(self.keychains) then
            local transforms = get_keychain_transforms(self.keychains)
            for k, v in pairs(self.keychains) do
                local t = transforms[k]
                G.shared_keychains[k].role.draw_major = self
                G.shared_keychains[k]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, t.mr, t.mx, t.my)
            end
        end
    end
}

function get_keychain_transforms(keychains)
    local base_x = 1.014      -- базовое смещение x
    local base_y = 2.299      -- базовое смещение y
    local angle_step = 0.2    -- угол между кейчейнами в радианах
    local x_step = 0.25        -- смещение по x между кейчейнами
    local y_step = -0.12       -- смещение по y между кейчейнами

    local transforms = {}
    local keys = {}
    for k, v in pairs(keychains) do
        if v then table.insert(keys, k) end
    end
    local count = #keys

    for i, k in ipairs(keys) do
        local offset = i - (count + 1) / 2  -- центрируем
        transforms[k] = {
            mx = base_x + offset * x_step,
            my = base_y + offset * y_step,
            mr = -offset * angle_step
        }
    end

    return transforms
end

function Card:set_keychain(_keychain, silent)
    silent = silent or false
    if not silent then play_sound('bda_keychain') end
    self:juice_up()
    SMODS.Keychains[_keychain]:apply(self, true)
    SMODS.enh_cache:write(self, nil)
end

function Card:calculate_keychain(context, key)
    if not self.keychains then return end
    local v = self.keychains[key]
    if v and type(v.ref.calculate) == 'function' then
        --sendDebugMessage('Вызывается функция калкулэйт у рефа')
        local o = v.ref:calculate(self, context)
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