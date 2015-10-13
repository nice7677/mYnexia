

charge = {

cast = function(player)

	player:sendAction(27, 1)
	player.sleep = 2
	player:setDuration("charge", 7000)
	player:sendAnimation(33)
	
end,


while_cast = function(player)

	player:sendAnimation(33)
end,


uncast = function(player)

	local pc = getTargetFacing(player, BL_PC)
	
	player.sleep = 0
	player:sendAction(28, 20)
	player:sendAnimation(171)
	if pc ~= nil then
		for i = 1, 6 do
			if player.side == 0 then player:sendAnimationXY(307, player.x, player.y-i) end
			if player.side == 1 then player:sendAnimationXY(307, player.x+i, player.y) end
			if player.side == 2 then player:sendAnimationXY(307, player.x, player.y+i) end
			if player.side == 3 then player:sendAnimationXY(307, player.x-i, player.y) end
		end
		pc:sendAnimation(332)
		for i = 1, 2 do player:playSound(59) end
	end
	player:calcStat()
end
}




























