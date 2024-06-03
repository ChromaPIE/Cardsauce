local jokerInfo = {
	name = 'Vincenzo',
	dispname = '文森佐',
	config = {},
	text = {
		"击败{C:attention}Boss盲注{}时",
		"生成一张{C:dark_edition}负片{C:attention}印错小丑",
	},
	rarity = 4,
	cost = 20,
	canBlueprint = true,
	canEternal = true,
	hasSoul = true,
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.e_negative
end


function jokerInfo.calculate(self, context)
	if context.end_of_round and G.GAME.blind.boss and (not context.individual) and (not context.repetition) then
		G.GAME.joker_buffer = G.GAME.joker_buffer + 1
		G.E_MANAGER:add_event(Event({
		func = function() 
			local card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_misprint', 'rif')
			card:set_edition({negative = true}, true, true)
			card:add_to_deck()
			G.jokers:emplace(card)
			card:start_materialize()
			G.GAME.joker_buffer = 0
		return true
		end}))   
		card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = "Corrupted!", colour = G.C.BLUE})
	end
end



return jokerInfo
	