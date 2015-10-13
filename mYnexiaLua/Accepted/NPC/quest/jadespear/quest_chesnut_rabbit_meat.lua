quest_chesnut_rabbit_meat = {

click = function(player, npc)

	local m = {graphic=convertGraphic(217, "item"),color=0}
	local c = {graphic=convertGraphic(214, "item"),color=0}
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0	
	
	if player.quest["chesnut_20"] == 0 and player.quest["rabbit_meat_20"] == 0 then
		player.quest["chesnut_20"] = 1 
		player.quest["rabbit_meat_20"] = 1
		player:dialogSeq({t, "Great! Well, lets go to the next quest."},1)				
		player:dialogSeq({m, "Next, you must to collect 20 'Rabbit meats'."}, 1)
		player:dialogSeq({c, "... and 20 'Chesnut'. Bring that items to me!"}, 1)
	elseif player.quest["chesnut_20"] == 1 and player.quest["rabbit_meat_20"] == 1 then
		menu = player:menuString("<b>[Jadespear]\n\nDid you finish your second quest?", {"Yes","Not yet/I forgot it", "Exit"})
		if menu == "Yes" then
			if player:hasItem(43, 20) == true and player:hasItem(41, 20) == true then
				player.quest["rabbit_meat_20"] = 2
				player.quest["chesnut_20"] = 2			
				player:removeItem(43, 20)
				player:removeItem(41, 20)
				player:giveXP(650)
				finishedQuest(player)
				quest_first_shield.click(player, npc)
			else
				player:sendAnimation(149)
				player:playSound(31)
				player:dialogSeq({t, "You didn't finish it!"},1)
			end
		elseif menu == "Not yet/I forgot it" then
			player:dialogSeq({m, "You must to bring me 20 'Rabbit meats'",
							c, "and... 20 'Chesnut' !! \nHuh, is it clear?"},1)
		end
	end
end
}