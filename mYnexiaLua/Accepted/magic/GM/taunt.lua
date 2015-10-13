
taunt = {

cast = function(player)

	local mob = player:getObjectsInMap(player.m, BL_MOB)
	
	if #mob > 0 then
		for i = 1, #mob do
			mob[i]:sendAnimation(248)
			mob[i].target = player.ID
		end
	end
	player:sendAction(6, 20)
end
}