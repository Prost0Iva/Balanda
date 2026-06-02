G.STATES.BDA_TEST = 23

local bda_toggle_shop = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    stop_use()
    G.CONTROLLER.locks.toggle_shop = true
    if G.shop then 
      for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:calculate_joker({ending_shop = true})
      end
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.shop.alignment.offset.y = G.ROOM.T.y + 29
          G.SHOP_SIGN.alignment.offset.y = -15
          return true
        end
      })) 
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
          G.shop:remove()
          G.shop = nil
          G.SHOP_SIGN:remove()
          G.SHOP_SIGN = nil
          G.STATE_COMPLETE = false
          
          G.STATE = G.STATES.BDA_TEST
          
          G.CONTROLLER.locks.toggle_shop = nil
          return true
        end
      }))
    end
end

local bda_update = Game.update
Game.update = function(self, dt)
    bda_update(self, dt)

    if G.STATE == G.STATES.BDA_TEST and not G.STATE_COMPLETE then
        G.STATE_COMPLETE = true

        G.bda_test = UIBox{
          definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR},
          nodes = bda_create_test_ui()},
          config = {align="cm",major = G.ROOM_ATTACH}}
    end
end

function bda_create_test_ui()
  G.test_jokers = CardArea(
    G.hand.T.x+0,
    G.hand.T.y+G.ROOM.T.y + 9,
    G.GAME.bda_fleamarket.joker_max*1.02*G.CARD_W,
    1.05*G.CARD_H, 
    {card_limit = G.GAME.bda_fleamarket.joker_max, type = 'shop', highlight_limit = 1})

  local t = {
    {n=G.UIT.C, config={align = "cm", padding = 0.1, emboss = 0.05, r = 0.1, colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
          {n=G.UIT.R,config={id = 'next_round_button', align = "cm", minw = 2.8, minh = 1.5, r=0.15,colour = G.C.RED, one_press = true, button = 'bda_leave_test', hover = true,shadow = true}, nodes = {
            {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
              {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                {n=G.UIT.T, config={text = localize('b_next_round_1'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
              }},
              {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                {n=G.UIT.T, config={text = localize('b_next_round_2'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
              }}   
            }},              
          }}
        }},
        {n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.L_BLACK, emboss = 0.05, minw = 8.2}, nodes={
            {n=G.UIT.O, config={object = G.test_jokers}},
        }}}
      }
    }}
  }
  
  for i = 1, G.GAME.bda_fleamarket.joker_max do
    local area = G.test_jokers
    local card = create_card("Joker", area, nil, nil, nil, nil, "j_joker")
    create_shop_card_ui(card, 'Joker', area)
    card:start_materialize()
    card:set_cost()
    area:emplace(card)
  end

  return t
end

G.FUNCS.bda_leave_test = function(e)
    if G.bda_test then
        G.bda_test:remove()
        G.bda_test = nil
    end
    G.STATE_COMPLETE = false
    G.STATE = G.STATES.BLIND_SELECT
end