saw = {

use = function(player)

	player:sendAnimationXY(292, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1))
	player:playSound(363)
	player:sendAction(7, 20)
end,


cast = function(player, target)

	if target:hasDuration("saw") then
		target:setDuration("saw", 0)
		return
	else
		target:setDuration("saw", 60000)
	end
end,

while_cast_125 = function(player)

	player:sendAnimationXY(292, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1))
	player:playSound(363)
end
}
