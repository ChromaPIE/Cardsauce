local jokerInfo = {
	name = 'Quarterdumb',
	dispname = '五毛呆瓜',
	config = {},
	text = {
		"若打出的牌包含{C:attention}同花",
		"有{C:green}#1#/2{}的几率",
		"在本{C:attention}盲注{}内{C:blue}+1{}出牌次数"
	},
	rarity = 4,
	cost = 20,
	canBlueprint = true,
	canEternal = true,
	hasSoul = true,
}

function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not self.debuff then
		if next(context.poker_hands["Flush"]) then
			if pseudorandom('mike') < G.GAME.probabilities.normal / 2 then
				ease_hands_played(1)
				return {
					card = self,
					message = "+1 Hand!",
					colour = G.C.BLUE
				}
			end
		end
	end
end



return jokerInfo
	