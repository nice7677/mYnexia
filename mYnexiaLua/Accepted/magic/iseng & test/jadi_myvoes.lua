
jadi_myvoes = {

cast = function(player)

	local pc = player:getObjectsInArea(BL_PC)
	
	player:sendAction(6, 20)
	
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 7) then
				if pc[i]:hasDuration("jadi_myvoes") then return else
					pc[i]:sendAnimationXY(292, pc[i].x, pc[i].y)	
					player:playSound(73)	
					pc[i]:setDuration("jadi_myvoes", 15000)	
					pc[i].gfxHair = 30	
					pc[i].gfxName = "mYvoes"	
					pc[i].gfxFace = 207	
					pc[i].gfxFaceA = 65535	
					pc[i].gfxFaceAT = 65535	
					pc[i].gfxNeck = 65535	
					pc[i].gfxArmor = 10114	
					pc[i].gfxCrown = 239	
					pc[i].gfxCrownC = 5	
					pc[i].gfxHelm = 65535	
					pc[i].gfxCape = 65535	
					pc[i].gfxArmorC = 37	
					pc[i].gfxShield = 65535	
					pc[i].gfxWeap = 65535	
					pc[i].gfxBoots = 65535
					pc[i].gfxClone = 1	
					pc[i]:refresh()
				end
			end
		end
	end
end,

while_cast = function(block)
					
	block.gfxHair = 30	
	block.gfxName = "mYvoes"	
	block.gfxFace = 207	
	block.gfxFaceA = 65535	
	block.gfxFaceAT = 65535	
	block.gfxNeck = 65535	
	block.gfxArmor = 10114	
	block.gfxCrown = 239	
	block.gfxCrownC = 5	
	block.gfxHelm = 65535	
	block.gfxCape = 65535	
	block.gfxArmorC = 37	
	block.gfxShield = 65535	
	block.gfxWeap = 65535	
	block.gfxBoots = 65535
	block.gfxClone = 1	
end,


uncast = function(player)
	
	player:sendAnimationXY(295, player.x, player.y)
	player:calcStat()
	player.gfxClone = 0
	player:refresh()
end
}
