local jokerInfo = {
	name = 'This Is Crack [WIP]',
	dispname = '掺东西了（未完成）',
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
	return { self.ability.extra.x_mult, self.ability.extra.crack_hand[1] }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1,
		crack_hand = {"无"} --replace with previous hand?
	}
end

function jokerInfo.calculate(self, context)
	if not context.blueprint then
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
end



return jokerInfo
	