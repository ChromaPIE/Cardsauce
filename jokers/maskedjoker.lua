local jokerInfo = {
	name = 'Masked Joker',
	dispname = '面甲小丑',
	config = {},
	text = {
		"若打出的牌均为{C:attention}钢铁牌",
		"每张给予{C:chips}+#1#{}筹码和{C:mult}+#2#{}倍率"
	},
	rarity = 2,
	cost = 7,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.m_steel
end

function jokerInfo.locDef(self)
	return { self.ability.extra.chips, self.ability.extra.mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		chips = 29,
		mult = 16
	}
end

function jokerInfo.calculate(self, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		local chimera = true
                for k, v in ipairs(context.full_hand) do
                    chimera = chimera and v.ability.name == 'Steel Card'
                end
                if not chimera then
                    return nil
                end
		return {
			chips = self.ability.extra.chips,
			mult = self.ability.extra.mult,
			card = self
		}
	end
end



return jokerInfo
	