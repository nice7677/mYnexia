target_do = {
	
cast = function(player, target)
	
	player:sendAction(6, 20)
	
	if target.blType == BL_PC then
		if target:hasDuration("target_do") then
			target:setDuration("target_do", 0)
		else
			target.state = 4
			target:updateState()
			target:setDuration("target_do", 720000)
		end
	end
end,

while_cast = function(player)

	player.state = 4
end,

uncast = function(player)

	if player.state ==4  then
		player.state = 0
		player:updateState()
	end
end
}