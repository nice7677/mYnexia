health	 = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	
	if not player:canAction(1, 1, 1) then return end
	
	player:sendAction(8, 20)
	addHealth(player, item.look)
end
}


mana = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	
	if not player:canAction(1, 1, 1) then return end
	
	player:addMagic(item.look)
	player:sendAction(8, 20)
end
}









































