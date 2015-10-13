
chu_rua = {

click = async(function(player, npc)
	
	
	local ginseng = {graphic = convertGraphic(14, "item"), color = 0}
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.quest["quest_churua"] == 0 then
		player:dialogSeq({t, "......."},1)
		return
	elseif player.quest["quest_churua"] == 1 then
		menu = player:menuString("Help me please..", {"What happened?", "Sorry old turtle, im busy!"})
		if menu == "What happened?" then
			player:dialogSeq({t, "Huhuhuhuhu..", "I need your help! it's urgent!!"}, 1)
			player:dialogSeq({ginseng, "I lost my precious item that i've been keeping for thousand years. It was a ginseng for my wife. I love that ginseng so much!"}, 1)
			player:dialogSeq({t, "Someone just stole it from me! I was hoping you can help me to get that ginseng back to me.", "Please give me back my lovely ginseng.."}, 1)
			player.quest["quest_churua"] = 2
			player:msg(4, "=== Chu Rua - Quest Updated! (1/6) ===", player.ID)
			finishedQuest(player)
		end
	elseif player.quest["quest_churua"] == 2 then
		menu = player:menuString("Help me please..", {"I got your ginseng back", "I'm gonna leave you!"})
		if menu == "I got your ginseng back" then
			if player:hasItem("chu_rua_ginseng", 1) == true then
				player:removeItem(Item("chu_rua_ginseng").id, 1)
				finishedQuest(player)
				player:giveXP(600)
				player.quest["quest_churua"] = 3
				player:msg(4, "=== Chu Rua - Quest Finished! (6/6) ===", player.ID)
				if player:hasLegend("help_churua") then player:removeLegendbyName("help_churua") end
				player:addLegend("Helping Chu Rua (mYnexia "..curYear()..", "..getCurSeason()..")", "help_churua", 62, 16)
				player:msg(4, "=== New Legend Added! ===", player.ID)
				player:dialogSeq({t, "Oh you really get it back! Thank you so much..", "Here's some reward for you. Anyway, thanks again for your help!"}, 1)
			else
				player:dialogSeq({t, "Please give me back my lovely ginseng.."}, 1)
			end
		end
	elseif player.quest["quest_churua"] == 3 then
		player:dialogSeq({t, "Hei, Thank you for your help! God bless you!  =p"})
	end
end),


say = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local say = string.lower(player.speech)
	
	if say == "reset" and player.gmLevel > 0 then
		player.quest["quest_churua"] = 1
		npc:talk(2, "Chu rua quest reset for "..player.name)
	end
end)
}



















