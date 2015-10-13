quest_first_shield = {

click = function(player, npc)

	local z = {graphic=convertGraphic(898, "item"),color=0}
	local x = {graphic=convertGraphic(2, "item"),color=0}
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.quest["first_shield"] == 0 then
		player.quest["first_shield"] = 1
		player:dialogSeq({t, "<b>[Jadespear]\n\nVery good.. okay, now it's your final quest. listen carefully"}, 1)		
		player:dialogSeq({z, "<b>[Jadespear]\n\nI'll teach you to creation.. let's start from the most basic creations like this 'Wood Shield'"}, 1)	
		player:dialogSeq({x, "<b>[Jadespear]\n\nTo create a shield like that, you need 3 pieces Wooden Sword. press Shift + I to issue a table creation. Then enter the third wooden sword and press OK."}, 1)	
		player:dialogSeq({t, "<b>[Jadespear]\n\nTake the shield on your hand and show it to me!"}, 1)				
		player:addItem("wooden_sword", 3)
	elseif player.quest["first_shield"] == 1 then
		shield = player:getEquippedItem(EQ_SHIELD)
		if shield ~= nil then
			if shield.yname == "wooden_shield" then
				player.quest["first_shield"] = 2	
				player:giveXP(650)	
				finishedQuest(player)
				player:dialogSeq({t, "<b>[Jadespear]\n\nNice .. Now you've completed all the preliminary work from me .. I will prepare the following tasks for you .. I'll call you so be prepared."},1)
				player.registry["student_of_jadespear"] = 2
			else
				player:dialogSeq({t, "<b>[Jadespear]\n\nThat's great, but i tell you to bring 'Wooden Shield' to me.. Not that!"},1)
			end
		else
			player:dialogSeq({t, "<b>[Jadespear]\n\nYou're not weild any shield on your hand! You think i'm blind?",1})
		end
	end
end
}
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	