target_do = {

cast = function(player, target)
	
	player:sendAction(6, 20)
	if player.gmLevel > 0 then
		if target.blType == BL_PC then
			if target.state == 4 then target.state = 0 else
				target.state = 4
			end
			target:updateState()
		end
	end
end
}