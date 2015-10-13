mythic_guardian = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	player:dialogSeq({t, "What's going on kid?"}, 1)
end)
}
	
	