npc_vending_help = {


click = function(player, npc)
	
	player:freeAsync()
	gfxClone(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	menu = player:menuString("What to do?", {"1", "2"})
end
}