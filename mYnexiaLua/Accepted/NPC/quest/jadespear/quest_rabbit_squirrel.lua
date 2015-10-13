quest_rabbit_squirrel = {
click = function(player, npc)

	local s = {graphic=convertGraphic(25, "monster"),color=3}
	local r = {graphic=convertGraphic(21, "monster"),color=29}
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.quest["rabbit_hunt"] == 0 and player.quest["squirrel_hunt"] == 0 then
		player.quest["rabbit_hunt"] = 1
		player.quest["squirrel_hunt"] = 1
		player:warp(1000,53,134)
		if player.sex==0 then player:addItem("flower_boy_outfit",1) end
		if player.sex==1 then player:addItem("flower_girl_outfit",1) end
		player:addItem("wooden_sword", 1)
		player:addGold(10000)		
		player:dialogSeq({t, "<b>[Jadespear]\n\nHello, Welcome to the kingdom of the winds! I will teach you all the basic things for playing. I hope you hear it. First of all, you must know the use of the keyboard shortcut",
								"<b>[Jadespear]\n\nYou can start by pressing? [Question mark]. That would explain any shortcuts that exist in the game. Next, you should know that in the bottom right of the screen.", 
								"<b>[Jadespear]\n\nThere's Vita, Mana, Gold, and Exp character that shows the current status. And also, there are the coordinates which shows your current location.",
								"<b>[Jadespear]\n\nFinally, you can use the spacebar to start attacking monsters or use the + [plus] to open a list of magic."}, 1)
		player:dialogSeq({r, "Well, for your first assignment, you can begin to hunt 10 Rabbits ..."}, 1)
		player:dialogSeq({s, "... And 10 Squirrels. Then we will talk about what your job back later. Ohya, you need to remember that the monsters do not kill other types of more than 10 types of after your job is finished."},1)
		player:dialogSeq({t, "Here, take this equipment. you'll need it."}, 1)

	elseif player.quest["rabbit_hunt"] == 1 and player.quest["squirrel_hunt"] == 1 then
		menu = player:menuString("Did you finish to hunt for 10 Rabbits, and 10 Squirrel?",{"Yes", "Not yet/Forgot my job", "Exit"})
		if menu == "Yes" then
			local rabbit = player:killCount(1)
			local rabbit2 = player:killCount(2)
			totalRabbit = rabbit+rabbit2
			if totalRabbit >= 10 and player:killCount(3) >= 10 then
				player.quest["rabbit_hunt"] = 2
				player.quest["squirrel_hunt"] = 2
				player:flushKills("squirrel")
				player:flushKills("rabbit1")
				player:flushKills("rabbit2")
				player:giveXP(650)
				finishedQuest(player)
				if player.quest["chesnut_20"] == 0 and player.quest["rabbit_meat_20"] == 0 then
					quest_chesnut_rabbit_meat.click(player, npc)
				end
			else
				player:dialogSeq({t, "Look like you forgot your job or what?"},1)
			end
		elseif menu == "Not yet/Forgot my job" then
			player:warp(1000, 53, 134)
			player:dialogSeq({r, "Well, for your first assignment, you can begin to hunt 10 Rabbits ..."}, 1)
			player:dialogSeq({s, "... And 10 Squirrels. Then we will talk about what your job back later. Ohya, you need to remember that the monsters do not kill other types of more than 10 types of after your job is finished."},1)
		end		
	end
end
}