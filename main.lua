--- STEAMODDED HEADER
--- MOD_NAME: Cardsauce
--- MOD_ID: Cardsauce
--- MOD_AUTHOR: [BarrierTrio/Gote]
--- MOD_DESCRIPTION: A set of Jokers based on Vinesauce!
--- BADGE_COLOUR: 32A852
--- DISPLAY_NAME: Cardsauce

local conf_cardsauce = {
	jokersToLoad = {

		'meat',
		-- 'twoface',
		'newjoker',
		'pivot',
		'speen',
		'diaper',
		-- 'roche',
		-- 'pacman',
		-- 'cryberry',
		'disguy',
		-- 'speedjoker',
		-- 'disturbedjoker',
		'chad',
		-- 'emmanuel',
		'reyn',
		'depressedbrother',
		-- 'werewolves',
		-- 'greyjoker',
		-- 'cousinsclub',
		-- 'gnorts',
		-- 'roger',
		-- 'shrimp',
		-- 'veryexpensivejoker',
		-- 'sohappy',
		'maskedjoker',
		'thisiscrack',
		-- 'charity',
		-- 'pepsecret',
		-- 'odio0',
		-- 'greenneedle',
		'vincenzo',
		'quarterdumb'
	},

}

local jokerInfoDefault = {
	name = 'NONE',
	config = nil,
	text = {'text'},
	baseEffect = nil,
	rarity = 1,
	cost = 1,
	canBlueprint = true,
	canEternal = true,
	hasSoul = false,
	--functions
	locDef = nil,
	init = nil,
	calculate = nil,
	tooltip = nil,
	
	update = nil,
	draw = nil
}

local function fillInDefaults(t,d)
	for k,v in pairs(d) do
		if t[k] == nil then t[k] = v end
	end
end


function SMODS.INIT.Cardsauce()
	local mod = SMODS.findModByID('Cardsauce')
	
	sendDebugMessage("AchievementsEnabler Activated!")
  	G.F_NO_ACHIEVEMENTS = false

	--misc localization stuff
	G.localization.misc.dictionary.ph_armageddon = "Annihilated by Odio"


	G.localization.descriptions.Other["guestartist1"] = {
			name = "客座画师",
			text = {
				"{E:1}SagaciousCejai"
			},
		}

	G.localization.descriptions.Other["guestartist2"] = {
			name = "客座代码作者",
			text = {
			  "{E:1}DPS2004"
			},
	}
	G.localization.descriptions.Other["guestartist3"] = {
		name = "客座代码作者",
		text = {
		  "{E:1}Nether"
		},
	}
	G.localization.descriptions.Other["guestartist4"] = {
		name = "Guest Coder",
		text = {
		  "{E:1}Mysthaps{}"
		},
	}
	G.localization.descriptions.Other["guestartist5"] = {
		name = "Voice Acting",
		text = {
		  "{E:1}AmtraxVA{}"
		},
	}
	G.localization.descriptions.Other["diapernote"] = {
		name = "作者注：",
		text = {
		  "我他妈画这个干嘛"
		},
	}
	G.localization.descriptions.Other["rogernote"] = {
		name = "Conversion Table",
		text = {
			  "5 {C:attention}fingers{} =",
			  "1 {C:attention}hand{}"
		},
	}
	--fix compatibility with G.GAME.probabilities.normal later
	G.localization.descriptions.Other["wheel2"] = {
		name = "命运之轮",
        text = {
            "有{C:green}1/4{}的几率",
            "为随机一张{C:attention}小丑牌",
            "添加{C:dark_edition}闪箔{}、{C:dark_edition}镭射{}",
            "或{C:dark_edition}多彩{}版本"
        },
	}
	
	
	--functions that are used by many cards go here.

	G.localization.descriptions.Blind.bl_wall.text = {"墙来了，哥们儿！"}
	G.localization.descriptions.Blind.bl_final_vessel.text = {"哈喽，墙！"}

	localizations = {}
	function mod.addLocalization(key,str)
		localizations[key] = str
	end
	
	function mod.getCardPosition(card)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				return i
			end
		end
		return nil
	end

	
	G.FUNCS.can_discard = function(e)
		if next(find_joker('Grey Joker')) then
			if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 4 then 
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				e.config.colour = G.C.RED
				e.config.button = 'discard_cards_from_highlighted'
			end
		else
			if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 then 
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				e.config.colour = G.C.RED
				e.config.button = 'discard_cards_from_highlighted'
			end
		end
	end
	
	local jokerUpdates = {}
	local jokerDraws = {}
	
	for i,v in ipairs(conf_cardsauce.jokersToLoad) do
		local jokerInfo = love.filesystem.load(mod.path .. 'jokers/'..v..'.lua')()
		fillInDefaults(jokerInfo,jokerInfoDefault)
		
		local spritePos = {x=0,y=0}
		local soulPos = nil
		if jokerInfo.hasSoul then
			spritePos = {x=1,y=0}
			soulPos = {x=2,y=0}
		end
		
		joker = SMODS.Joker:new(
			jokerInfo.name,
			v,
			jokerInfo.config,
			spritePos,
			{name = jokerInfo.dispname or jokerInfo.name, text = jokerInfo.text},
			jokerInfo.rarity,
			jokerInfo.cost,
			true,
			true,
			jokerInfo.canBlueprint,
			jokerInfo.canEternal,
			jokerInfo.baseEffect,
			nil,
			soulPos
		)
		
		joker:register()
		
		local jself = SMODS.Jokers['j_'..v]
		
		
		if jokerInfo.locDef then
			jself.loc_def = jokerInfo.locDef
		end
		if jokerInfo.init then
			jself.set_ability = jokerInfo.init
		end
		if jokerInfo.calculate then
			jself.calculate = jokerInfo.calculate
		end
		if jokerInfo.tooltip then
			jself.tooltip = jokerInfo.tooltip
		end
		
		if jokerInfo.update then
			table.insert(jokerUpdates,{name = jokerInfo.name, func = jokerInfo.update})
		end
		if jokerInfo.draw then
			table.insert(jokerDraws,{name = jokerInfo.name, func = jokerInfo.draw})
		end
		
		
		--load sprite
		SMODS.Sprite:new('j_'..v,mod.path,v..'.png',71,95,'asset_atli'):register()
		
	end
	
	--card updates

	local card_updateref = Card.update
	function Card.update(self, dt)
		if G.STAGE == G.STAGES.RUN then
			if self.config.center.key == "j_diaper" then
				self.ability.extra.mult = 0
            	for k, v in pairs(G.playing_cards) do
                	if v:get_id() == 2 then self.ability.extra.mult = self.ability.extra.mult+self.ability.extra.mult_mod end
				end
            end
		end
		card_updateref(self, dt)
	end

	-- SMODS.Spectral:new(name, slug, config, pos, loc_txt, cost, consumeable, discovered, atlas)
	local c_quixotic = SMODS.Spectral:new('Quixotic', 'quixotic', { }, { x = 0, y = 0 }, {
    	name = 'Quixotic',
    	text = { 'Gain an {C:attention}Ethereal Tag' }
	}, 4, true, true, 'quixotic')
	c_quixotic:register()
	local sprite = SMODS.Sprite:new("quixotic", SMODS.findModByID("Cardsauce").path, "quixotic.png", 71, 95, "asset_atli")
	sprite:register()

	function SMODS.Spectrals.c_quixotic.loc_def(center, info_queue)
		info_queue[#info_queue+1] = G.P_TAGS.tag_ethereal
		return {}
	end

	function SMODS.Spectrals.c_quixotic.can_use(card)
		-- stop_use and whatnot are handled by the loader, so you don't need to worry about it
		return true
	end

	function SMODS.Spectrals.c_quixotic.use(card, area, copier)
			G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_ethereal'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
	end

	--updates
	local card_updateRef = Card.update
	function Card.update(self, dt)
		if G.STAGE == G.STAGES.RUN then
			for i,v in ipairs(jokerUpdates) do
				if self.ability.name == v.name then
					v.func(self,dt)
				end
			end
		end
		card_updateRef(self,dt)
	end
	
	--draws
	local card_drawRef = Card.draw
	function Card.draw(self, layer)
		for i,v in ipairs(jokerDraws) do
			if self.ability.name == v.name then
				v.func(self,dt)
			end
		end
		card_drawRef(self,layer)
	end
	
	for k,v in pairs(localizations) do
		G.localization.misc.dictionary[k] = v
	end
    init_localization()
	
	



end