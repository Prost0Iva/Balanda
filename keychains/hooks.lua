--local bda_card_init = Card.init
--function Card:init(X, Y, W, H, card, center, params)
--    self.keychains = {}
--
--    bda_card_init(self, X, Y, W, H, card, center, params)
--end

local bda_card_draw = Card.draw
function Card:draw(layer)

    bda_card_draw(self, layer)
    
    if self.keychains then
        --sendDebugMessage(tostring(self.keychains))
        if #self.keychains ~= 0 then
            
            sendDebugMessage('Нашёл брелки')
            for k, v in pairs(self.ability.keychains) do
                sendDebugMessage('Нрисовал брелок')
                G.shared_keychains[k].role.draw_major = self
                G.shared_keychains[k]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 1.014, 2.299)
            end
        end
    end
end