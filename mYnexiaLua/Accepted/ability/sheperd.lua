

sheperd = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local scissors = {graphic = convertGraphic(2956, "item"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local ability = "Sheperd"
	local opts = {}
	if player.registry["learned_sheperd"] == 0 then table.insert(opts, "I want to learn sheperd") else table.insert(opts, "Take me to your farm") end
	table.insert(opts, "Buy tools")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>["..ability.."]\n\nHei, i can teach you to do sheperd if you want!", opts)

	if menu == "I want to learn sheperd" then
		player:dialogSeq({t, "<b>["..ability.."]\n\nFirst of all, you need to understand what is an 'ability'. In this kingdom we've got three types of abilities..",
						"<b>["..ability.."]\n\nThat is..\n\n1. Gathering\n2. Processing\n3. Production",
						"<b>[Gathering]\n\nGathering some raw materials such as woods, wool, amber, meat, water, etc..\n\nDifficulty: Normal\nPrice     : Middle",
						"<b>[Processing]\n\nChanging raw materials into something usefull such as steel, gold, precious, stones, etc..\n\nDifficulty: Easy\nPrice     : Low",
						"<b>[Production]\n\nCreating a usefull items or equipments such as clothes, armory, weaponry, medicine, etc..\n\nDifficulty: Hard\nPrice     : High",
						"<b>["..ability.."]\n\nSheperd is one of 'gathering' ability type. So, you'll work as a farmer and trim wools from sheeps.",
						"<b>["..ability.."]\n\nHowever, there is two different method of gathering. The first one is slower. that is gather by collecting from ore stone (Automated). Second one is much faster. it's gather by hitting them using a pickaxe and of course i can sell it to you.",
						}, 1)
		choice = player:menuString("<b>["..ability.."]\n\nAnyway, are you interested on sheperd?", {"Yes, i do", "No, thanks"})
		if choice == "Yes, i do" and player.registry["learned_sheperd"] == 0 then
			player:dialogSeq({scissors, "<b>["..ability.."]\n\nIn order to do sheperd, you will need a tool to help you working.",
								"<b>["..ability.."]\n\nYou could get the basic tool from me. But it can help you work for only 30 minutes long. If you need a longer duration of tool, you could got it from item mall, events, quest, and mini games.",
							t, "<b>["..ability.."]\n\nI think my explanation is enough. Now, take this tool and try it by your self."}, 1)
			if player:hasLegend("beginner_sheperd") then player:removeLegendbyName("beginner_sheperd") end
			player:addLegend("Beginner sheperd", "beginner_sheperd", 137, 108)
			player:msg(4, "=== New legend added! ===", player.ID)
			player.registry["learned_sheperd"] = 1
			player.registry["sheperd_level"] = 1
			player.registry["sheperd_tnl"] = 500
			player:sendMinitext("You've learned Sheperd ability!")
			player:addItem("scissors", 1)
		end
	elseif menu == "Take me to your farm" then
		if player.registry["learned_sheperd"] == 1 then
			player:warp(10022, 14, 27)
			player:sendAnimation(16)
			player:playSound(29)
		end
	elseif menu == "Buy tools" then
		tools = player:menuString("<b>["..ability.."]\n\nWhich type of tools do you want?", {"Common tools", "Advanced tools [BP]", "Advanced tools [PP/EP]", "Exit"})
		if tools == "Common tools" then
			player:buyExtend("<b>["..ability.."]\n\nWhat item do you wish to buy?", {40, 21, 30025})
		elseif tools == "Advanced tools [BP]" then
			buyAdvancedTools(player, "<b>["..ability.."]\n\nWhat item do you wish to buy?", {30026, 30027}, {45, 80}, "bp")
		elseif tools == "Advanced tools [PP/EP]" then
			buyAdvancedTools(player, "<b>["..ability.."]\n\nWhat item do you wish to buy?", {30026, 30027, 30028}, {800, 1500, 2500}, "pp")
		end
	end
end),

say = function(player, npc)

	if string.lower(player.speech) == "reset" then
		player.registry["learned_sheperd"] = 0
		player.registry["sheperd_level"] = 0
		player.registry["sheperd_tnl"] = 0	
		npc:talk(2, "Sheperd Reset done for "..player.name)
		player:removeLegendbyName("beginner_sheperd")
	end
end,

cast = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local dura
	
	if not player:canCast(1,1,0) then return end
	if player:hasDuration("sheperd") then return end
	if player:hasDuration("ability") then return end
	
	if weap ~= nil then
		dura = math.ceil(weap.dura*1825)
		player:setDuration("sheperd", dura)
		ability.cast(player)	
	end
end,

while_cast = function(player)

	local ore = getTargetFacing(player, BL_MOB)
	
	if ore == nil then
		player:setDuration("sheperd", 0)
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
