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
        --G.STATE_COMPLETE = true

        G.bda_test = UIBox({
            definition = bda_create_test_ui(),
            config = {align = 'cm', major = G.ROOM}
        })
    end
end

function bda_create_test_ui()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
    {n=G.UIT.C, config={button = "bda_leave_test", colour = G.C.BLUE }, nodes={
  {n=G.UIT.T, config={text = "Press Me!", colour = G.C.WHITE}}
}}
}}
end

G.FUNCS.bda_leave_test = function(e)
    if G.bda_test then
        G.bda_test:remove()
        G.bda_test = nil
    end
    G.STATE_COMPLETE = false
    G.STATE = G.STATES.BLIND_SELECT
end