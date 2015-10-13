
shade = {

cast = function(player, target)

	if target.blType == BL_PC then
		if target.state == 2 or target:hasDuration("shade") then
			anim(player)
			player:sendMinitext("Spell already cast!")		
			return
		else
			if target.state == 0 then
				player:sendAction(6, 20)
				target.state = 2
				target:sendAnimationXY(21, target.x, target.y)
				player:playSound(28)
				player:sendMinitext("You cast shade")
				target:sendMinitext(player.name.." cast Shade on you")
				target:setDuration("shade", 30000)
				player:setAether("shade", 60000)
				target:updateState()
			else
				anim(player)
				player:sendMinitext("You cannot cast on target now")
			end
		end
	end
end,

while_cast = function(player)

	
end,

uncast = function(player)

	player:calcStat()
	if player.state == 2 then
		player.state = 0
		player:updateState()
	end
end
}