ore_mining = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local pickaxe = {graphic = convertGraphic(3359, "item"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	if player.registry["learned_ore_mining"] == 0 then table.insert(opts, "I want to learn ore mining") end
	table.insert(opts, "Buy tools")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Ore Mining]\n\nHei, i can teach you to do ore mining if you want!", opts)
	
	if menu == "I want to learn ore mining" then
		player:dialogSeq({t, "<b>[Ore Mining]\n\nFirst of all, you need to understand what is an 'ability'. In this kingdom we've got three types of abilities..",
						"<b>[Ore Mining]\n\nThat is..\n\n1. Gathering\n2. Processing\n3. Production",
						"<b>[Gathering]\n\nGathering some raw materials such as woods, wool, amber, meat, water, etc..\n\nDifficulty: Normal\nPrice     : Middle",
						"<b>[Processing]\n\nChanging raw materials into something usefull such as steel, gold, precious, stones, etc..\n\nDifficulty: Easy\nPrice     : Low",
						"<b>[Production]\n\nCreating a usefull items or equipments such as clothes, armory, weaponry, medicine, etc..\n\nDifficulty: Hard\nPrice     : High",
						"<b>[Ore Mining]\n\nOre mining is one of 'gathering' ability type. You will work as a miner who gather ore from stones. You could sell it to market or ore collectors at kaming camp.",
						"<b>[Ore Mining]\n\nHowever, there is two different method of gathering. The first one is slower. that is gather by collecting from ore stone (Automated). Second one is much faster. it's gather by hitting them using a pickaxe and of course i can sell it to you.",
						}, 1)
		choice = player:menuString("<b>[Ore Mining]\n\nAnyway, are you interested on ore mining? don't worry, it's free..", {"Yes, i do", "No, thanks"})
		if choice == "Yes, i do" and player.registry["learned_ore_mining"] == 0 then
			player:dialogSeq({pickaxe, "<b>[Ore Mining]\n\nIn order to do ore mining, you will need a tool to help you working.",
								"<b>[Ore Mining]\n\nYou could get the basic tool from me. But it can help you work for only 30 minutes long. If you need a longer duration of tool, you could got it from item mall, events, quest, and mini games.",
							t, "<b>[Ore Mining]\n\nI think my explanation is enough. Now, take this tool and try it by your self."}, 1)
			if player:hasLegend("beginner_ore_mining") then player:removeLegendbyName("beginner_ore_mining") end
			player:addLegend("Beginner ore mining", "beginner_ore_mining", 125, 108)
			player:msg(4, "=== New legend added! ===", player.ID)
			player.registry["learned_ore_mining"] = 1
			player.registry["ore_mining_level"] = 1
			player.registry["ore_mining_tnl"] = 500			
			player:sendMinitext("You've learned ore mining ability!")
			player:addItem("wooden_pickaxe", 1)
		end
	elseif menu == "Buy tools" then
		tools = player:menuString("<b>[Ore Mining]\n\nWhich type of tools do you want?", {"Common tools", "Advanced tools [BP]", "Advanced tools [PP/EP]", "Exit"})
		if tools == "Common tools" then
			player:buyExtend("<b>[Ore Mining]\n\nWhat item do you wish to buy?", {40, 21, 30009	})
		elseif tools == "Advanced tools [BP]" then
			buyAdvancedTools(player, "<b>[Ore Mining]\n\nWhat item do you wish to buy?", {30010, 30011}, {45, 80}, "bp")
		elseif tools == "Advanced tools [PP/EP]" then
			buyAdvancedTools(player, "<b>[Ore Mining]\n\nWhat item do you wish to buy?", {30010, 30011, 30012}, {800, 1500, 2500}, "pp")
		end
	end
end),

say = function(player, npc)

	if string.lower(player.speech) == "reset" then
		player.registry["learned_ore_mining"] = 0
		player.registry["ore_mining_level"] = 0
		player.registry["ore_mining_tnl"] = 0	
		npc:talk(2, "Reset done for "..player.name)
		player:removeLegendbyName("beginner_ore_mining")
	end
end,

cast = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local dura
	
	if not player:canCast(1,1,0) then return end
	if player:hasDuration("ore_mining") then return end
	if player:hasDuration("ability") then return end
	
	if weap ~= nil then
		dura = math.ceil(weap.dura*1825)
		player:setDuration("ore_mining", dura)
		ability.cast(player)	
	end
end,

while_cast = function(player)

	local ore = getTargetFacing(player, BL_MOB)
	
	if ore == nil then
		player:setDuration("ore_mining", 0)
		player:setDuration("ability", 0)
	else
		if player:hasDuration("ability") then return else
			ability.cast(player)
		end
	end
end,


uncast = function(player)
	
	player:calcStat()
end
}




















	
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			