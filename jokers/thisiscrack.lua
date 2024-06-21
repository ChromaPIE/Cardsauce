local jokerInfo = {
	name = 'This Is Crack',
	dispname = '掺东西了',
	config = {},
	text = {
		"连续打出{C:attention}同一牌型{}时",
		"本牌获得{X:mult,C:white}X0.1{}倍率",
		"中断将重置倍率",
		"{C:inactive}（当前为{X:mult,C:white}X#1#{C:inactive}倍率）",
		"{C:inactive}（当前牌型：{C:attention}#2#{C:inactive}）"
	},
	rarity = 3,
	cost = 8,
	canBlueprint = true,
	canEternal = true,
	hasSoul = true,
}

function jokerInfo.locDef(self)
	local hand_var = self.ability.extra.crack_hand and localize(self.ability.extra.crack_hand, 'poker_hands') or localize('k_none')
	return { self.ability.extra.x_mult, self.ability.extra.crack_hand }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1,
		crack_hand = {"无"} --replace with previous hand?
	}
end

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not context.blueprint then
		local hand = context.scoring_name
		if hand == self.ability.extra.crack_hand or self.ability.extra.crack_hand == "None" then
			self.ability.extra.x_mult = self.ability.extra.x_mult + 0.1
		else
			self.ability.extra.crack_hand = hand
			if self.ability.extra.x_mult > 1 then
                self.ability.extra.x_mult = 1
                return {
                    card = self,
                    message = localize('k_reset')
                }
            end
		end
		self.ability.extra.crack_hand = hand
	  end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
			Xmult_mod = self.ability.extra.x_mult, 
			--colour = G.C.MULT
		}
	end
	--[[	if not context.blueprint then
		local reset = true
        --local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
        for k, v in pairs(G.GAME.hands) do
            if k == context.scoring_name and v.visible then
                reset = false
            end
        end
        if reset then
            if self.ability.x_mult > 1 then
                self.ability.x_mult = 1
                return {
                    card = self,
                    message = localize('k_reset')
                }
            end
        else
            self.ability.x_mult = self.ability.x_mult + 0.1
        end
		self.ability.extra.crack_hand = context.scoring_name
	end
	]]--
end



return jokerInfo
	