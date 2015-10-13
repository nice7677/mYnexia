decrease_speed = {
cast = function(player, target)
	
	if not player:canCast(1,1,0) then return end
	
	if player.state ~= 0 then
		player:sendMinitext("You cannot do that")
		return
	else
		player:sendAction(6, 20)
		
		if target.blType == BL_PC and target.state ~= 1 then
			if target.speed <= 0 then
				player.speed = 80
				player:sendMinitext("Speed : Back to normal(80)")
				player:setDuration("increase_speed", 0)
				player:refresh()
				return
			end
			
			target.speed = target.speed + 20
			target:sendMinitext("Move speed: "..target.speed)
			target:setDuration("decrease_speed", 720000)
			target:refresh()
		else
			anim(player)
			player:sendMinitext("Invalid target!")
		end
	end
end,


uncast = function(player)
	
	player:calcStat()
	player.speed = 80
	player:updateState()
end
}
