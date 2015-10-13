showShop = {

click = function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2

	local pc = Player(player.registry["show_shop"])
	if pc == nil then return end
	gfxClone(pc, npc)

	local opts = {}
	table.insert(opts, "Hello")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>[Vending]\n\nWhat to do?", opts)
	
end
}