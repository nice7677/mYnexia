

heal_test = {

cast = function(player, target)

	if target.blType == BL_PC then
		if target.state == 1 then
			anim(player)
			player:sendMinitext("Target already die!")
			return
		else
			player:sendAction(6, 20)
			target:addHealthExtend(1000, 1,1,1,1,0)
		end
	end
end
}