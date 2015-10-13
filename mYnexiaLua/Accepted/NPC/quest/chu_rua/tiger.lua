
tiger = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.quest["talk_to_tiger"] == 1 then
		if player:hasItem(Item("chu_rua_ginseng").id, 1) == false then
			player:dialogSeq({t, "That ginseng are under the mountain.\n\n[X : 007,   Y : 009]"})
		else
			player:dialogSeq({t, "Oh, you already got it in your inventory. Don't forget to send my regards for that turtle."})
		end
	else
		player:dialogSeq({t, "I'm looking for a rabbit. Have you seen him?"})
	end
end),


say = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local c = {graphic = convertGraphic(174, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local say = string.lower(player.speech)
	
	if string.find(say, "(.*)rabbit(.*)") or string.find(say, "(.*)kelinci(.*)") then
		if player.quest["quest_churua"] == 2 and player.quest["say_hello"] == 1 and player.quest["say_ginseng"] == 1 and player.quest["talk_to_rocks"] == 1 then
			if player.quest["talk_to_tiger"] == 0 then
				npc:sendAnimation(248)
				player:dialogSeq({t, "Hei, do you know where he is?", 
				"He stole that old turtle ginseng and put it over there under the mountain.\n\n[X : 007,   Y : 009]",
				c, "You can take it, and give it back to Mr.turtle and, please send my regards to him. Now i'm gonna give some lesson to that little thief!"}, 1)
				finishedQuest(player)
				player.quest["talk_to_tiger"] = 1
				if player:hasItem("chu_rua_ginseng", 1) == true then player:removeItem(Item("chu_rua_ginseng").id, Item("chu_rua_ginseng").amount) end
				npc:dropItemXY(Item("chu_rua_ginseng").id, 1, 2001, 7, 9, player.ID)
				player:sendAnimationXY(131, 7, 9)
				player:playSound(112)
				player:msg(4, "=== Chu Rua - Quest Updated! (5/6) ===", player.ID)
			elseif player.quest["talk_to_tiger"] == 1 then
				player:dialogSeq({t, "He stole that old turtle ginseng, and put it over there under the mountain.\n\n[X : 007,   Y : 009]", "I'm gonna give some lesson to that little thief!"})
			end
		end
	end
	if string.find(say, "(.*)reset(.*)") ~= nil and player.gmLevel > 0 then
		player.quest["talk_to_tiger"] = 0
		npc:talk(2, "Reset quest done for "..player.name)
		if player:hasItem(Item("chu_rua_ginseng").id, 1) == true then player:removeItem(Item("chu_rua_ginseng").id, 1) end
	end
end)
}