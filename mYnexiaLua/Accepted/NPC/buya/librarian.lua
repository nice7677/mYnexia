
librarian = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "Buy")
	table.insert(opts, "Exit")
	
	menu = player:menuString("What can i help you?", opts)
	if menu == "Buy" then
		item = {18142, 18144, 18170, 18171}
		player:buyExtend("What do you need?", item)
	end
end)
}