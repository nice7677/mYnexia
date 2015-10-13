firecracker1 = {

use = function(player)
	
	player:sendAction(6, 20)
	player:sendAnimation(388, player.x, player.y)
	player:playSound(6)
end
}