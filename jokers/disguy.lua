local jokerInfo = {
	name = 'DIS JOAKERRR',
	dispname = '介锅扫糗！！',
	config = {},
	text = {
		"买姜打出的{C:attention}2{}和{C:attention}5",
		"在计翻C随Z获得一过{C:attention}簪藏",
	},
	rarity = 1,
	cost = 6,
	canBlueprint = false,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end
]]--

function jokerInfo.init(self)
	self.ability.extra = {
		messageIndex = 0
	}
end

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not self.debuff and not context.blueprint then
		local enhancements = {
			[1] = G.P_CENTERS.m_bonus,
			[2] = G.P_CENTERS.m_mult,
			[3] = G.P_CENTERS.m_wild,
			[4] = G.P_CENTERS.m_glass,
			[5] = G.P_CENTERS.m_steel,
			[6] = G.P_CENTERS.m_stone,
			[7] = G.P_CENTERS.m_gold,
			[8] = G.P_CENTERS.m_lucky,
		}
		local messages = {
			[1] = "玩游C啦，BINTY！！！",
			[2] = "还有饿C翻宗啦！！！",
		}
		for k, v in ipairs(context.scoring_hand) do --maybe swap this out with context.full_hand? -dps
			if v:get_id() == 2 or v:get_id() == 5 then 
				v:set_ability(enhancements[pseudorandom('OONDORTOOL', 1, 8)], nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = messages[(self.ability.extra.messageIndex % 2) + 1], colour = G.C.MONEY})
				self.ability.extra.messageIndex = self.ability.extra.messageIndex + 1
			end
		end
	end
end



return jokerInfo
	