lobby_npc = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "How to use elevator")
	table.insert(opts, "Exit")
	
	menu = player:menuString("<b>Receptionist\n\nWelcome to Nexia Tower, how can i help you?", opts)
	if menu == "How to use elevator" then
		player:dialogSeq({t, "Press 'O' button in front of elevator door to open/close"},1)
	end
end)
}
	