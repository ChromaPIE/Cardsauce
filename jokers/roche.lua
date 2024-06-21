local jokerInfo = {
	name = 'Motorcyclist Joker',
	config = {},
	text = {
		"If round ends with exactly {C:money}$#1#{},",
		"create a {C:planet}Planet{} card for",
		"your most-used hand",
	},
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist5", set = "Other"}
end

function jokerInfo.locDef(self)
	return { self.ability.gil }
end

function jokerInfo.init(self)
	self.ability.gil = 13
end


function jokerInfo.calculate(self, context)
	if context.end_of_round and not self.debuff and not context.individual and not context.repetition then
		if G.GAME.dollars == self.ability.gil then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				local card_type = 'Planet'
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						
						local _handname, _played, _order = 'High Card', -1, 100
                    	for k, v in pairs(G.GAME.hands) do
                        	if v.played > _played or (v.played == _played and _order > v.order) then 
                            	_played = v.played
								_order = v.order
                            	_handname = k
                        	end
                    	end

							local _planet = 0
							for k, v in pairs(G.P_CENTER_POOLS.Planet) do
								if v.config.hand_type == _handname then
									_planet = v.key
								end
							end
							local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
						
						--modded_play_sound('roche',false,1,1)
						if not context.blueprint then
							Custom_Play_Sound("RochePlanetCard",false,1.3,1)
						end
						return true
					end)}))
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
				--ret.effect = true
			end
		end
	end
end



return jokerInfo
	