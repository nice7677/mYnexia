jadespear = {
click = async(function(player, npc)

	local shield = player:getEquippedItem(EQ_SHIELD)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local studentOfJadespear = player.registry["student_of_jadespear"]
	
	if studentOfJadespear == 0 then
		menu = player:menuString("<b>[Jadespear]\n\nWhat do you need from me?", {"I want to be your student", "Nothing"})
		if menu == "I want to be your student" then
			player.registry["student_of_jadespear"] = 1
			if player.quest["rabbit_hunt"] == 0 and player.quest["squirrel_hunt"] == 0 then
				quest_rabbit_squirrel.click(player, npc)
			end
		end
		
	elseif studentOfJadespear == 1 then
	
		if player.quest["rabbit_hunt"] == 1 and player.quest["squirrel_hunt"] == 1 then
			quest_rabbit_squirrel.click(player, npc)
		elseif player.quest["rabbit_hunt"] == 2 and player.quest["squirrel_hunt"] == 2 then
			if player.quest["chesnut_20"] == 0 and player.quest["rabbit_meat_20"] == 0 then
				quest_chesnut_rabbit_meat.click(player, npc)
			elseif player.quest["chesnut_20"] == 1 and player.quest["rabbit_meat_20"] == 1 then
				quest_chesnut_rabbit_meat.click(player, npc)
			elseif player.quest["chesnut_20"] == 2 and player.quest["rabbit_meat_20"] == 2 then
				if player.quest["first_shield"] == 0 then
					quest_first_shield.click(player, npc)
				elseif player.quest["first_shield"] == 1 then
					quest_first_shield.click(player, npc)
				end
			end
		end
		
	elseif studentOfJadespear == 2 then
		if player.level < 5 then
			player:dialogSeq({t, "<b>[Jadespear]\n\nNow you've completed all the preliminary work from me .. I will prepare the following tasks for you .. I'll call you so be prepared."},1)
			return
		else
			if player.quest["quest_churua"] == 0 then
				churua = player:menuString("<b>[Jadespear]\n\nWhat a nice day, don't you think so?", {"Chu rua need help", "Exit"})
				if churua == "Chu rua need help" then
					player:dialogSeq({t, "<b>[Jadespear]\n\nI have a old best friend in Dae shore. Apparently, he needs some help."}, 1)
					ok = player:menuString("<b>[Jadespear]\n\nCan you please to help him?", {"Sure, no problem", "No, i've been busy now"})
					if ok == "Sure, no problem" then
						player:warp(2001, 59, 51)
						player:sendAnimation(16)
						player:playSound(29)
						player.quest["quest_churua"] = 1
						player:dialogSeq({t, "I'm taking you to Dae shore. You can find him here."}, 1)
					end
				end
			end
		end
	end
end),


say = async(function(player, npc)

	if player.gmLevel > 0  then
		local say = string.lower(player.speech)
		if string.find(say, "(.*)reset(.*)") then
			menu = player:menuString("<b>[Jadespear]\n\nWhat do you want to reset?", {"All", "Quest Rabbit & Squirrel Hunt", "Quest Collecting Monster Drop", "Quest Wooden Shield", "Exit"})
			if menu == "All" then
				player.registry["student_of_jadespear"] = 0
				player:flushKills("rabbit1")
				player:flushKills("rabbit2")
				player:flushKills("squirrel")
				player.quest["rabbit_hunt"] = 0
				player.quest["squirrel_hunt"] = 0
				player.quest["rabbit_meat_20"] = 0
				player.quest["chesnut_20"] = 0
				player.quest["first_shield"] = 0
				npc:talk(2, npc.name..": All quest reset!")
			elseif menu == "Quest Rabbit & Squirrel Hunt" then
				player.registry["student_of_jadespear"] = 1
				player:flushKills("rabbit1")
				player:flushKills("rabbit2")
				player:flushKills("squirrel")				
				player.quest["rabbit_hunt"] = 0
				player.quest["squirrel_hunt"] = 0
				npc:talk(2, npc.name..": Quest 'Rabbit and Squirrel Hunt' reset!")
			elseif menu == "Quest Collecting Monster Drop" then
				player.registry["student_of_jadespear"] = 1
				player.quest["chesnut_20"] = 0
				player.quest["rabbit_meat_20"] = 0
				npc:talk(2, npc.name..": Quest 'Collect Chesnut and Meats' reset!")
			elseif menu == "Quest Wooden Shield" then
				player.registry["student_of_jadespear"] = 1
				player.quest["first_shield"] = 0
				npc:talk(2, npc.name..": Quest 'First Shield' reset!")
			end
		end
	end
end)
}
				
				
				
		
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				