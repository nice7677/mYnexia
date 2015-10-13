bank = {

click = function(player, npc)

	local pc = Player(player.registry["on_page"])
	
	if pc == nil then user_pages.click(player, npc) return end
	
	gfxClone(pc, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 2
	
	local opts = {}
	table.insert(opts, "")
	
	menu = player:menuString("<b>["..pc.name.."'s Bank]\n\n", opts)
	
end

}