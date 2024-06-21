local jokerInfo = {
	name = 'Very Expensive Joker',
	dispname = '天价小丑',
	config = {},
	text = {
		"购买本牌将耗尽你的{C:attention}资金",
		"所付金额每有{C:money}$10",
		"本牌获得{X:mult,C:white}X0.5{}倍率",
		"{C:inactive}（当前为{X:mult,C:white} X#1# {C:inactive}倍率）",
	},
	rarity = 1,
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

local add_to_deck_ref = Card.add_to_deck

function Card:add_to_deck(from_debuff)
	add_to_deck_ref(self, from_debuff)
	if self.config.center_key == 'j_veryexpensivejoker' then
		if G.GAME.dollars > 0 then 
			self.ability.extra.dollars = G.GAME.dollars
		else
			self.ability.extra.dollars = 0
		end
		self.ability.extra.x_mult = (math.floor(self.ability.extra.dollars/10)/2) + 1
		ease_dollars(-(self.ability.extra.dollars) +1)
		card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}}})
	end
end


function jokerInfo.calculate(self, context)
	
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
			Xmult_mod = self.ability.extra.x_mult, 
		}
	end
end



return jokerInfo
	