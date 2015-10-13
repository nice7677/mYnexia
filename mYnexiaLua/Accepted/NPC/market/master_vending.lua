

master_vending = {

click = async(function(player, npc)

	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local ransel = {graphic = convertGraphic(5180, "item"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
	if player.registry["get_vending_ransel"] == 0 then
		player:dialogSeq({t, "Welcome to mYnexia fun server!\n\nI'm master vending. First of all, i'll explain what is vending and of course how to do vending.\n",
							ransel, "\nVending is a way here to sell your goods/items. You can do this by pressing F4 key. The button only works if you're equipped 'Vending ransel' that i'll give to you later.",
							"\nPress F4key and select 'Add item' to put your stuff in ransel which will be on sale. Anyway, you can also set your shop promotion text for telling what item you're selling, price, info, shop's name, etc..",
							"\nAfter that, select 'Open shop' option to get in vending mode. In this mode, if other people are clicked on you.. They'll get a menu with the items you put on ransel earlier.",
							"\nYou can leave your character and AFK in this mode. If other player is buying your stuff, there's an automatic nmail about transaction info and information of your sold item sended to your character",
							ransel, "\nOkay, i think my explanation is enough.. here you go, take this and try it by your self."}, 1)
		player.registry["get_vending_ransel"] = 1
		player:addItem("vending_ransel", 1)
		player:giveXP(500)
		finishedQuest(player)
	else
		player:dialogSeq({t, "You could sell your items by vending!"})
	end
end)
}