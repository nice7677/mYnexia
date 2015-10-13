rocks = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if player.quest["quest_churua"] == 2 and player.quest["say_hello"] == 1 and player.quest["say_ginseng"] == 1 then
		if player.quest["talk_to_rocks"] == 0 then
			player:dialogSeq({t, "....", "........", "..............."}, 1)
			finishedQuest(player)
			player.quest["talk_to_rocks"] = 1
			player:msg(4, "=== Chu Rua - Quest Updated! (4/6) ===", player.ID)
		else
			player:dialogSeq({t, "The wind blowing.... I just realized 	that i was talking with no one."})
		end
	end
end),

say = function(player, npc)

	local say = string.lower(player.speech)
	
	if player.gmLevel > 0 then
		if say == "reset" then
			player.quest["talk_to_rocks"] = 0
			npc:talk(2, npc.name..": Quest reset done for "..player.name)
		end
	end
end
}