weaving = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local string = {graphic = convertGraphic(1315, "item"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	if player.registry["learned_weaving"] == 0 then table.insert(opts, "I want to learn weaving") end
	table.insert(opts, "Buy tools")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Weaving]\n\nHei, i can teach you to do weaving if you want!", opts)
	
	if menu == "I want to learn weaving" then
		player:dialogSeq({t, "<b>[Weaving]\n\nFirst of all, you need to understand what is an 'ability'. In this kingdom we've got three types of abilities..",
						"<b>[Weaving]\n\nThat is..\n\n1. Gathering\n2. Processing\n3. Production",
						"<b>[Gathering]\n\nGathering some raw materials such as woods, wool, amber, meat, water, etc..\n\nDifficulty: Normal\nPrice     : Middle",
						"<b>[Processing]\n\nChanging raw materials into something usefull such as steel, gold, precious, stones, etc..\n\nDifficulty: Easy\nPrice     : Low",
						"<b>[Production]\n\nCreating a usefull items or equipments such as clothes, armory, weaponry, medicine, etc..\n\nDifficulty: Hard\nPrice     : High",
						"<b>[Weaving]\n\nWeaving is one of processing ability. You will work as a weaver who produces a raw clothes and legendary clothes. You could sell it to market or Clothes collector at kaming camp."
						}, 1)
		choice = player:menuString("<b>[Weaving]\n\nAnyway, are you interested on weaving?", {"Yes, i do", "No, thanks"})
		if choice == "Yes, i do" and player.registry["learned_weaving"] == 0 then
			player:dialogSeq({string, "<b>[Weaving]\n\nIn order to do weaving, you will need a tool to help you working.",
								"<b>[Weaving]\n\nYou could get the basic tool from me. But it can help you work for only 30 minutes long. If you need a longer duration of tool, you could got it from item mall, events, quest, and mini games.",
							t, "<b>[Weaving]\n\nI think my explanation is enough. Now, take this tool and try it by your self."}, 1)
			if player:hasLegend("beginner_weaving") then player:removeLegendbyName("beginner_weaving") end
			player:addLegend("Beginner weaving", "beginner_weaving", 64, 108)
			player:msg(4, "=== New legend added! ===", player.ID)
			player.registry["learned_weaving"] = 1
			player.registry["weaving_level"] = 1
			player.registry["weaving_tnl"] = 500
			player:sendMinitext("You've learned weaving ability!")
			player:addItem("wooden_string", 1)
		end
	elseif menu == "Buy tools" then
		tools = player:menuString("<b>[Weaving]\n\nWhich type of tools do you want?", {"Common tools", "Advanced tools [BP]", "Advanced tools [PP/EP]", "Exit"})
		if tools == "Common tools" then
			player:buyExtend("<b>[Weaving]\n\nWhat item do you wish to buy?", {40, 21, 30005})
		elseif tools == "Advanced tools [BP]" then
			buyAdvancedTools(player, "<b>[Weaving]\n\nWhat item do you wish to buy?", {30006, 30007}, {45, 80}, "bp")
		elseif tools == "Advanced tools [PP/EP]" then
			buyAdvancedTools(player, "<b>[Weaving]\n\nWhat item do you wish to buy?", {30006, 30007, 30008}, {800, 1500, 2500}, "pp")
		end
	end
end),

say = function(player, npc)

	if string.lower(player.speech) == "reset" then
		player.registry["learned_weaving"] = 0
		player.registry["weaving_level"] = 0
		player.registry["weaving_tnl"] = 0	
		npc:talk(2, "Reset done for "..player.name)
		player:removeLegendbyName("beginner_weaving")
	end
end,

cast = function(player)

	local weap = player:getEquippedItem(EQ_WEAP)
	local dura
	
	if not player:canCast(1,1,0) then return end
	if player:hasDuration("weaving") or player:hasDuration("ability") then return end

	if weap ~= nil then
		if weap.yname == "wooden_string" then
			dura = math.ceil(weap.dura*1825)
		elseif weap.yname == "bronze_string" then
			dura = (weap.dura*1825)*2
		elseif weap.yname == "silver_string" then
			dura = (weap.dura*1825)*3
		elseif weap.yname == "golden_string" then
			dura = (weap.dura*1825)*4			
		end
		
		player:setDuration("weaving", dura)
		ability.cast(player)
	end
end,

while_cast = function(player)

	local obj = getObjFacing(player, player.side)
	
	if obj == nil then
		player:setDuration("weaving", 0)
		player:setDuration("ability", 0)
	else
		if obj == 3204 and player.m == 10005 then
			if player:hasDuration("ability") then return else
				ability.cast(player)
			end
		else
			player:setDuration("weaving", 0)
		end
	end
end,


uncast = function(player)
	
	player:calcStat()
end
}