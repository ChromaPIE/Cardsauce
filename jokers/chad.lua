local jokerInfo = {
	name = 'No No No No No No No No No No No',
	dispname = '别 别 别 别 不要 不 别 别 别',
	config = {},
	text = {
		"您好，Cloud，是我，Chudlot。",
		"我毕生的夙愿便是",
		"成为LocalThunk出品的热门游戏",
		"“小丑牌”中的一名小丑。",
		"而如您亲眼所见，我已然到达了彼岸！",
		"眼下，请您在找寻原型小丑的途中捡起您遇到的“雪人”，",
		"它将使我能够获取更多我自身的复制品。",
		"并推动猛汉家园的再次统一！",
		"当聚集到足够多的猛汉之力时，",
		"我们便可变形成为新新大猛汉！",
		"最终，全人类将变成与我一样",
		"猛猛又汉汉的猛汉族群。"
	},
	rarity = 1,
	cost = 0,
	canBlueprint = false,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	