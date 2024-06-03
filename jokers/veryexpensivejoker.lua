local jokerInfo = {
	name = 'Very Expensive Joker [WIP]',
	dispname = '天价小丑（未完成）',
	config = {},
	text = {
		"购买本牌将耗尽你的{C:attention}资金",
		"所付金额每有{C:money}$10",
		"本牌获得{X:mult,C:white}X0.5{}倍率",
		"{C:inactive}（当前为{X:mult,C:white} X#1# {C:inactive}倍率）",
	},
	rarity = 2,
	cost = 0,
	canBlueprint = false,
	canEternal = true
}
function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1,
		dollars = 0
	}
end

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	