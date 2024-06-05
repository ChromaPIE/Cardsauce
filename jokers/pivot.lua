local jokerInfo = {
	name = 'Pivyot',
	dispname = '中心人物',
	config = {},
	text = {
		"有{C:green}#1#/2{}的几率",
		"在打出{C:attention}高牌{}时",
		"提升其等级"
	},
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}


function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end


--[[
function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not self.debuff then
		if context.scoring_name == "High Card" then
			if pseudorandom('pivot') < G.GAME.probabilities.normal / 2 then
				return {
					card = self,
					level_up = true,
					message = localize('k_level_up_ex')
				}
			end
		end
	end
end



return jokerInfo
	