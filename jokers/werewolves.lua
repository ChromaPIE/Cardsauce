local jokerInfo = {
	name = 'That\'s Werewolves [WIP]',
	dispname = '狼人来辣！',
	config = {},
	text = {
		"{X:mult,C:white}X3{}倍率",
		"但包含{C:attention}同花",
		"的出牌将不被允许"
	},
	rarity = 2,
	cost = 7,
	canBlueprint = true,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	