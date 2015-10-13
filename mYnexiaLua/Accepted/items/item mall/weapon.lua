

weapon_im = {

use = function(player)

	local item = player:getInventoryItem(player.invSlot)
	
	if player.gfxClone == 0 then
		gfxClone(player, player)
		player.gfxWeap = item.look
		player.gfxWeapC = item.lookC
		player.gfxClone = 1
	else
		player.gfxClone = 0
	end
	player:updateState()
end
}




