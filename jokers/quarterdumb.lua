local jokerInfo = {
	name = 'Quarterdumb',
	config = {},
	text = {
		"{C:green}#1# in 2{} chance to gain {C:blue}+1{} Hand",
		"this {C:attention}Blind{} if played hand",
		"contains a {C:attention}Flush{}",
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
	