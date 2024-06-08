local jokerInfo = {
	name = 'Meat',
	dispname = '大肉虫',
	config = {},
	text = {
		"为下{C:attention}#1#{}手高牌中计分的牌",
		"随机打上{C:attention}蜡封"
	},
	rarity = 1,
	cost = 5,
	canBlueprint = false,
	canEternal = false
}


function jokerInfo.locDef(self)
	return {self.ability.extra.cardsRemaining}
end


function jokerInfo.init(self)
	self.ability.extra = {
		cardsRemaining = 3
	}
end

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not self.debuff and not context.blueprint then
		if context.scoring_name == "High Card" then
			local seal = {
				[1] = "Gold",
				[2] = "Red",
				[3] = "Blue",
				[4] = "Purple",
			}
			for k, v in ipairs(context.scoring_hand) do
				G.E_MANAGER:add_event(Event({
				func = function()
					v:juice_up()
					v:set_seal(seal[pseudorandom('meat', 1, 4)], nil, true)
					return true
				end
				})) 
			end
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = "Yeow!", colour = G.C.MONEY})
			self.ability.extra.cardsRemaining = self.ability.extra.cardsRemaining - 1
		end


		if self.ability.extra.cardsRemaining <= 0 then 
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					self.T.r = -0.2
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
						func = function()
							G.jokers:remove_card(self)
							self:remove()
							self = nil
							return true
						end
					})) 
					return true
				end
			})) 
			return {
				message = "Nyomp!",
				colour = G.C.MONEY
			}
		end
	end
end



return jokerInfo
	