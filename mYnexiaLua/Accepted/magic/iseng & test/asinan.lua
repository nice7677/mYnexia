
asinan = {

cast = function(player)
	
	player:sendAction(6, 20)
	
	if player:hasDuration("asinan") then
		player:setDuration("asinan", 0)
	return else
		player.gfxWeap = 133
		player.gfxShield = 25
		player.gfxArmor = 343
		player.gfxCrown = 65
		player.gfxCape = 13
		player.gfxCrownC = 26
		player.gfxName = "Asinan"
		player.gfxClone = 1
		player:updateState()
		player:sendAnimationXY(354, player.x, player.y)
		player:sendAnimationXY(309, player.x, player.y)
		for i = 1, 3 do player:playSound(81) player:playSound(83) end
		player:playSound(109)
		player:playSound(106)
		player:playSound(80)
		player:setDuration("asinan", 60000)
	end
end,

while_cast = function(player)
		
	player.attackSpeed = 10
	player.speed = 35
	player.gfxWeap = 133
	player.gfxShield = 25
	player.gfxArmor = 343
	player.gfxCrown = 65
	player.gfxCape = 13
	player.gfxCrownC = 26
	player.gfxName = "Asinan"
	player.gfxClone = 1
	player:sendAnimation(309)
	aroundAnimation(player, 409)
	player:playSound(117)
end,

uncast = function(player)
	
	player:calcStat()
	player.gfxClone = 0
	player:updateState()
end
}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	