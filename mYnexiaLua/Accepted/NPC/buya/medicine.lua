medicine = {
click = async(function(player,npc)
	local i = 0
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0	
	
	local opts = {"Buy", "Exit"}
	local obat = {28, 29, 30, 31, 32, 33, 34, 35, 36}
	
	menuOption = player:menuString("What do you want?", opts)
	if(menuOption=="Buy") then
		player:buyExtend("What do you need from me?", obat)
	end
end)
}
