local jokerInfo = {
	name = 'Diaper Joker',
	dispname = '尿不湿小丑',
	config = {},
	text = {
		"{C:attention}完整牌组{}内",
		"每有一张{C:attention}2",
		"本牌{C:mult}+2{}倍率",
		"{C:inactive}（当前为{C:mult}+#1#{C:inactive}倍率）",
	},
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "diapernote", set = "Other"}
end

function jokerInfo.locDef(self)
	return { self.ability.extra.mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		mult = 0,
		mult_mod = 2
	}
end

function jokerInfo.calculate(self, context)
	if context.joker_main and context.cardarea == G.jokers and not self.debuff then
		return {
			message = localize{type='variable',key='a_mult',vars={self.ability.extra.mult}},
			mult_mod = self.ability.extra.mult,
			colour = G.C.MULT
		}
	end

end



return jokerInfo
	