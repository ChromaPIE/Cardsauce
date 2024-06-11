local jokerInfo = {
	name = 'Depressed Brother',
	dispname = '心碎老哥',
	config = {},
	text = {
		"出牌触发了{C:attention}Boss盲注{}限制时",
		"本牌获得{C:chips}+13{}筹码",
		"{C:inactive}（当前为{C:chips}+#1#{C:inactive}筹码）"
	},
	rarity = 2,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
end

function jokerInfo.locDef(self)
	return { self.ability.extra.chips }
end

function jokerInfo.init(self)
	self.ability.extra = {
		chips = 13,
		chip_mod = 13
	}
end

function jokerInfo.calculate(self, context)
	if context.joker_main and context.cardarea == G.jokers then
		if G.GAME.blind.triggered and not (context.blueprint or context.repetition or context.individual) then 
			self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
		end

		return {
			message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
			chip_mod = self.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end



return jokerInfo
	