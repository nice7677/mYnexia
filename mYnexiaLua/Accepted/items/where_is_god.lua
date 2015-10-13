where_is_god = {

use = function(player)
	
	local god = Player(2)
	
	if god ~= nil then
		player:warp(god.m, god.x, god.y)
		player:sendAnimation(16)
		player:sendAnimation(29)
		player:playSound(29)
	else
		player:sendAnimation(246)
		player:sendMinitext("God is not online")
	end
end
}