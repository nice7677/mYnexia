


jadi_ravel = {

cast = function(player)

	local pc = player:getObjectsInArea(BL_PC)
	
	player:sendAction(6, 20)
	
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 7) then
					pc[i]:sendAnimationXY(292, pc[i].x, pc[i].y)
					player:playSound(73)
					pc[i]:setDuration("jadi_ravel", 15000)
					pc[i].gfxWeap = 65535
					pc[i].gfxName = "Ravel"
					pc[i].gfxArmor = 10239
					pc[i].gfxCrown = 336
					pc[i].gfxShield = 65535
					pc[i].gfxFace = pc[i].face
					pc[i].gfxHair = pc[i].hair
					pc[i].gfxArmorC = 0
					pc[i].gfxCrownC = 0
					pc[i].gfxCape = 65535
					pc[i].gfxHelm = 255
					pc[i].gfxFaceA = 65535
					pc[i].gfxFaceAT = 65535
					pc[i].gfxNeck = 65535
					pc[i].gfxClone = 1
					pc[i]:sendStatus()
					pc[i]:updateState()
					pc[i]:calcStat()
					player:refresh()
			end
		end
	end
end,

while_cast = function(block)
					
	block.gfxName = "Ravel"
	block.gfxWeap = 65535	
	block.gfxArmor = 10239				
	block.gfxCrown = 336				
	block.gfxShield = 65535				
	block.gfxFace = block.face				
	block.gfxHair = block.hair				
	block.gfxArmorC = 0				
	block.gfxCrownC = 0				
	block.gfxCape = 65535				
	block.gfxHelm = 255				
	block.gfxFaceA = 65535				
	block.gfxFaceAT = 65535				
	block.gfxNeck = 65535
	block.gfxClone = 1
end,


uncast = function(player)
	
	player:sendAnimationXY(295, player.x, player.y)
	player:calcStat()
	player.gfxClone = 0
	player:refresh()
end
}
