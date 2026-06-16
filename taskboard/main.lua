G.STATES.TASKBOARD = 23

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
          
          G.STATE = G.STATES.TASKBOARD
          
          G.CONTROLLER.locks.toggle_shop = nil
          return true
        end
      }))
    end
end

local bda_update = Game.update
Game.update = function(self, dt)
    bda_update(self, dt)

    if G.STATE == G.STATES.TASKBOARD and not G.STATE_COMPLETE then
      G.taskboard = UIBox{
        definition = {n=G.UIT.ROOT,
        nodes = bda_create_taskboard_ui(),
        config = {align="cm", colour = G.C.CLEAR}},
        config = {align='cm', offset = {x=0,y=10}, major = G.hand, bond = 'Weak'}}
        
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.taskboard.alignment.offset.y = 0
          G.taskboard.alignment.offset.x = 0
          return true
        end
      }))
      
      G.STATE_COMPLETE = true

      
    end
end

function bda_create_taskboard_ui()
G.taskboard_jokers = CardArea(
    G.hand.T.x+0,
    G.hand.T.y+G.ROOM.T.y + 9,
    5*1.02*G.CARD_W,
    2*1.05*G.CARD_H, 
    {card_limit = G.GAME.bda_taskboard.tasks_max, type = 'shop', highlight_limit = 1})

    local taskboard_sign = AnimatedSprite(0,0, 4.4, 2.2, G.ANIMATION_ATLAS['bda_taskboard'])
    taskboard_sign:define_draw_steps({
      {shader = 'dissolve', shadow_height = 0.05},
      {shader = 'dissolve'}
    })
    G.TASKBOARD_SIGN = UIBox{
      definition = 
        {n=G.UIT.ROOT, config = {colour = G.C.DYN_UI.MAIN, emboss = 0.05, align = 'cm', r = 0.1, padding = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0.1, minw = 4.72, minh = 3.1, colour = G.C.DYN_UI.DARK, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = taskboard_sign}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {localize('ph_diversify_run')}, colours = {lighten(G.C.GOLD, 0.3)},shadow = true, rotate = true, float = true, bump = true, scale = 0.5, spacing = 1, pop_in = 1.5, maxw = 4.3})}}
            }},
          }},
        }},
      config = {
        align="cm",
        offset = {x=0,y=-15},
        major = G.HUD:get_UIE_by_ID('row_blind'),
        bond = 'Weak'
      }
    }
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = (function()
          G.TASKBOARD_SIGN.alignment.offset.y = 0
          return true
      end)
    }))

    local t = {
        {n=G.UIT.R, config={align = "tm", padding = 0.1, emboss = 0.05, r = 0.1, minh = 12, colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.L_BLACK, emboss = 0.05, minw = 8.2}, nodes={
                        {n=G.UIT.O, config={object = G.taskboard_jokers}},
                    }},
                    {n=G.UIT.R,config={id = 'next_round_button', align = "cm", minw = 2.8, minh = 1.5, r=0.15,colour = G.C.RED, one_press = true, button = 'bda_leave_taskboard', hover = true,shadow = true}, nodes = {
                        {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                                {n=G.UIT.T, config={text = localize('b_next_round_1'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                                {n=G.UIT.T, config={text = localize('b_next_round_2'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }}   
                        }}            
                    }}
                }
            }
        }

    create_tasks()

    return t
end

function create_tasks()
  local tasks = {
    "j_bda_task_missing",
    --"j_bda_task_wanted",
    --"j_bda_task_other",
  }
  for i = 1, G.GAME.bda_taskboard.tasks_max do
      local area = G.taskboard_jokers
      local card = create_card("Joker", area, nil, nil, nil, nil, tasks[pseudorandom('taskboard_tasks', 1, #tasks)])
      create_taskboard_card_ui(card, 'Joker', area)
      card:start_materialize()
      card.ability.extra_value = -1
      card:set_cost()
      area:emplace(card)
  end
end

G.FUNCS.bda_leave_taskboard = function(e)
    if G.taskboard then
        G.taskboard:remove()
        G.taskboard = nil
        G.TASKBOARD_SIGN:remove()
        G.TASKBOARD_SIGN = nil
    end
    G.STATE_COMPLETE = false
    G.STATE = G.STATES.BLIND_SELECT
end

local bda_cardarea_draw = CardArea.draw
CardArea.draw = function(self)
    if self.config.type == 'hand' and G.STATE == G.STATES.TASKBOARD then
        return
    end
    bda_cardarea_draw(self)
end

function create_taskboard_card_ui(card, type, area)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.43,
      blocking = false,
      blockable = false,
      func = (function()
        if card.opening then return true end
        local t1 = {
         n=G.UIT.ROOT, config = {id = 'take_button', ref_table = card, minh = 1.1, padding = 0.1, align = 'cr', colour = G.C.GREEN, shadow = true, r = 0.08, minw = 1.1, one_press = true, func = 'can_take', button = 'take_task', hover = true, focus_args = {type = 'none'}}, nodes={
           {n=G.UIT.B, config = {w=0.1,h=0.6}},
           {n=G.UIT.C, config = {align = 'cm'}, nodes={
             {n=G.UIT.R, config = {align = 'cm', maxw = 1}, nodes={
               {n=G.UIT.T, config={text = localize('b_take'),colour = G.C.WHITE, scale = 0.5}}
             }},
           }} 
         }}
        card.children.take_button = UIBox{
          definition = t1,
          config = {
            align="bm",
            offset = {x=0,y=-0.3},
            major = card,
            bond = 'Weak',
            parent = card
          }
        }
          return true
      end)
    }))
end

G.FUNCS.take_task = function(e)
  local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        c1.area:remove_card(c1)
        c1:add_to_deck()
        if c1.children.take_button then c1.children.take_button:remove() end
        c1.children.take_button = nil
        remove_nils(c1.children)
        G.jokers:emplace(c1)
        for i = 1, #G.jokers.cards do
          G.jokers.cards[i]:calculate_joker({take_task = true, card = c1})
        end
        play_sound('card1')
        G.CONTROLLER:save_cardarea_focus('jokers')
        G.CONTROLLER:recall_cardarea_focus('jokers')
        return true
      end
    }))
  end

G.FUNCS.can_take = function(e)
    --if then
    --    e.UIBox.states.visible = false
    --    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    --    e.config.button = nil
    --else
        if e.config.ref_table.highlighted then
          e.UIBox.states.visible = true
        else
          e.UIBox.states.visible = false 
        end
        e.config.colour = G.C.GREEN
        e.config.button = 'take_task'
    --end
end