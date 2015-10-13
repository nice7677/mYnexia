jadi_barclayz = {
cast = function(player)

	local pc = player:getObjectsInMap(player.m, BL_PC)
	
		if #pc > 0 then
			for i = 1, #pc do
				pc[i].gfxHair = 134			
				pc[i].gfxHairC = 9			
				pc[i].gfxName = "barclayz"			
				pc[i].gfxFace = 226			
				pc[i].gfxFaceC = 0			
				pc[i].gfxFaceA = 65535				
				pc[i].gfxFaceAT = 65535				
				pc[i].gfxNeck = 65535			
				pc[i].gfxArmor = 10056			
				pc[i].gfxArmorC = 25			
				pc[i].gfxCrown = 65535			
				pc[i].gfxHelm = 65535			
				pc[i].gfxCape = 65535					
				pc[i].gfxShield = 65535			
				pc[i].gfxWeap = 65535			
				pc[i].gfxBoots = 65535			
				pc[i].gfxClone = 1			
				pc[i]:sendAnimation(292)			
				pc[i]:setDuration("jadi_barclayz", 15000)			
				pc[i]:refresh()			
			end
		end

	for i = 1, 3 do player:playSound(73) end
	player:refresh()
	player:sendAction(6, 20)
end,


while_cast = function(player)
	
	player.gfxHair = 134
	player.gfxHairC = 9					
	player.gfxName = "barclayz"					
	player.gfxFace = 226					
	player.gfxFaceC = 0					
	player.gfxFaceA = 65535						
	player.gfxFaceAT = 65535						
	player.gfxNeck = 65535					
	player.gfxArmor = 10056					
	player.gfxArmorC = 25					
	player.gfxCrown = 65535					
	player.gfxHelm = 65535					
	player.gfxCape = 65535							
	player.gfxShield = 65535					
	player.gfxWeap = 65535					
	player.gfxBoots = 65535					
	player.gfxClone = 1			
end,


uncast = function(player)

	player.gfxClone = 0
	player:calcStat()
	player:refresh()
end
}