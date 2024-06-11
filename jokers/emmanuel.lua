local jokerInfo = {
	name = 'Emmanuel Blast',
	dispname = '以马内力',
	config = {},
	text = {
		"回合结束时有{C:green}#1#/8{}的几率",
		"生成一个{C:dark_edition}负片标签"
	},
	rarity = 1,
	cost = 4,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_TAGS.tag_negative
end


function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

--[[function jokerInfo.init(self)

end]]--


function jokerInfo.calculate(self, context)
	if context.end_of_round and not self.debuff and not context.individual and not context.repetition then
			if pseudorandom('blast') < G.GAME.probabilities.normal / 8 then
				G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_negative'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
			end
		return
	end
end



return jokerInfo
	