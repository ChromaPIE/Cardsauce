local jokerInfo = {
	name = 'The NEW Joker!',
	dispname = '新小丑！',
	config = {},
	text = {
		"打出的{C:attention}增强{}卡牌",
		"在计分时给予{C:mult}+#1#{}倍率"
	},
	rarity = 1,
	cost = 4,
	canBlueprint = true,
	canEternal = true
}


function jokerInfo.locDef(self)
	return {self.ability.extra.mult}
end


function jokerInfo.init(self)
	self.ability.extra = {
		mult = 4
	}
end

--[[
function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		if context.other_card.ability.effect ~= 'Base'
		then
			return {
				mult = self.ability.extra.mult,
				card = self
			}
		end
	end
end



return jokerInfo
	