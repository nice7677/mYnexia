butcher = {
click = async(function(player, npc)
	
	local t = {graphic = convertGraphic(npc.look, "monster"),color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	local opts = {}
	table.insert(opts, "Buy")
	table.insert(opts, "Sell")
	
	local item = {43, 41, 45, 49, 50, 51, 52, 53, 63, 66}
	
	menu = player:menuString("Yes? What can i help you?", opts)
	
	if menu == "Buy" then
		player:buyExtend("What do you want to buy?", item)
	elseif menu == "Sell" then
		player:sellExtend("What do you want to sell?", item)
	end
	
end)

}