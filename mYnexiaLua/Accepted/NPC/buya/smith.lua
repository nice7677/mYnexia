smith = {
click = async(function(player,npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = {"Buy Weapon", "Sell Weapon", "Repair Item", "Repair Equipped Item", "Exit"}
	local senjata = {3001, 3002, 3041, 3042, 3043, 3044, 3045, 3046, 3047, 3048, 3055}
	local menuOption
	local menuOptionBuy

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	menuOption = player:menuString("Welcome kid, what do you need?", opts)
	
	if (menuOption == "Buy Weapon") then
		player:buyExtend("What weapon do you need?", senjata)
	elseif (menuOption == "Sell Weapon") then
		player:sellExtend("What weapon you want to sell?", senjata)
	elseif (menuOption == "Repair Item") then
		player:repairExtend()
	elseif (menuOption == "Repair Equipped Item") then
		player:repairAll(player, npc)
--		repairAll(player, npc)
	end
end)
}