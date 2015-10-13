rabbit = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.quest["say_hello"] == 0 and player.quest["say_ginseng"] == 0 then
		player:dialogSeq({t, "Go away! leave me alone."})
	else
		player:dialogSeq({t, "Please don't tell the tiger that i'm here."})
	end
end),


say = async(function(player, npc)
	
	local rock = {graphic = convertGraphic(175, "monster"), color = 0}
	local ginseng = {graphic = convertGraphic(14, "item"), color = 0}
	local t = {graphic = convertGraphic(21, "monster"), color = 29}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0	

	local say = string.lower(player.speech)
	
	if player.quest["quest_churua"] == 2 then
		if string.find(say, "(.*)hello(.*)") ~= nil then
			if player.quest["say_hello"] == 0 then
				player:msg(4, "=== Chu Rua - Quest Updated! (2/5) ===", player.ID)
				finishedQuest(player)
				player.quest["say_hello"] = 1
				player:dialogSeq({t, "Hei, what is it? I'm hidding from a tiger. Please don't tell him that i'm here."}, 1)
			end
		elseif string.find(say, "(.*)ginseng(.*)") ~= nil then
			if player.quest["say_hello"] == 1 and player.quest["say_ginseng"] == 0 then
				if not distanceSquare(player, npc, 4) then
					npc:sendAnimation(248)
					npc:talk(0, npc.name..": What? i can't hear you.. Come closer "..player.name)
					return
				else
					player:dialogSeq({ginseng, "Hah? How do you know about that ginseng?", 
					t, "I know i was wrong to stole that ginseng. I tried to give it back, but i don't have any courge to stand up and tell Mr.turtle",
					rock, "Then, i throw that ginseng away near the rocks. You'll find it there."}, 1)
					
					player:msg(4, "=== Chu Rua - Quest Updated! (3/6) ===", player.ID)
					finishedQuest(player)
					player.quest["say_ginseng"] = 1
				end
			end
		elseif say == "reset" then
			if player.gmLevel > 0 then
				player.quest["say_hello"] = 0
				player.quest["say_ginseng"] = 0
				npc:talk(2, "Reset quest done for "..player.name)
			end
		end
	end
end)
}	