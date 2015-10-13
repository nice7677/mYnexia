where_is_god = {

use = function(player)
	
	local god = Player(2)
	
	if god ~= nil then
		if god.m == 20017 then
			anim(player)
			player:sendMinitext("The god is busy now")
		return else
			player:warp(god.m, god.x, god.y)
			player:sendAnimation(16)
			player:sendAnimation(29)
			player:playSound(29)
		end
	else
		player:sendAnimation(246)
		player:sendMinitext("God is not online")
	end
end
}