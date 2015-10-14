
onLuaTest = function(player)
	
	-- test_extendHit
	
	moved = true
	mob = player:getObjectsInMap(player.m, BL_NPC)
	
	player:sendAnimationXY(198, player.x-3, player.y-1)
	player:sendAnimationXY(198, player.x-2, player.y-2)
	player:sendAnimationXY(198, player.x-1, player.y-3)
	player:sendAnimationXY(198, player.x+1, player.y-3)
	player:sendAnimationXY(198, player.x+2, player.y-2)
	player:sendAnimationXY(198, player.x+3, player.y-1)
	
	--player:sendAnimationXY(198, player.x+3, player.y+1)
	--player:sendAnimationXY(198, player.x+2, player.y+2)
	--player:sendAnimationXY(198, player.x+1, player.y+3)
	--player:sendAnimationXY(198, player.x-1, player.y+3)
	--player:sendAnimationXY(198, player.x-2, player.y+2)
	--player:sendAnimationXY(198, player.x-3, player.y+1)
	--
end






soccerCostume = function(player)

	all = player:getUsers()
	local r = math.random(1,2)
	if #all > 0 then
		for i = 1, #all do
			all[i]:sendAction(22, 120)
			gfxClone(all[i], all[i])
			Player("jzhang").gfxArmor = 10027
			Player("jzhang").gfxName = "Baloteli"
			
			Player("god").gfxArmor = 10027
			Player("god").gfxName = "Christian ronaldo"
			
			Player("sanji").gfxArmor = 10020
			Player("sanji").gfxName = "David Beckham"
			
			Player("roku").gfxArmor = 10020
			Player("roku").gfxName = "Lionel messi"	
			
			all[i].gfxArmorC = 0
			all[i].gfxWeap = 65535
			all[i].gfxCape = 65535
			all[i].gfxShield = 65535
			all[i].gfxClone = 1
			all[i]:updateState()
			all[i]:sendAnimation(16)
		end
	end
end































resetStatus = function(player)
	
	player.exp = 0
	player:giveXP(1)
	player.baseMight = 1
	player.baseGrace = 1
	player.baseWill = 1
	player.baseAC = 75
	player.baseResist = 75
	player.baseHealth = 100
	player.baseMagic = 100
	player.baseRegen = 0
	player.baseVRegen = 0
	player.baseMRegen = 0
	player.baseMinDam = 0
	player.baseMaxDam = 0
	player.basePhysDeduct = 0
	player.baseProtection = 0
	player.baseSpeed = 90
	player.weapDuraMod = 1
	player.armorDuraMod = 1
	player.registry["base_might"] = 0
	player.registry["base_grace"] = 0
	player.registry["base_will"] = 0
	player.registry["base_ac"] = 0
	player.registry["base_mr"] = 0
	player.registry["base_vita"] = 0
	player.registry["base_mana"] = 0
	player.registry["base_regen"] = 0
	player.registry["base_vregen"] = 0
	player.registry["base_mregen"] = 0
	player.registry["base_mindam"] = 0
	player.registry["base_maxdam"] = 0
	player.registry["base_pd"] = 0
	player.registry["base_prot"] = 0
	player.registry["base_speed"] = 0
	player.registry["base_wdm"] = 0
	player.registry["base_adm"] = 0
	player.ap = 0			
	player.sp = 0			
	player.level = 1			
	player.class = 0			
	player:calcStat()			
	player.health = pc.maxHealth			
	player.magic = pc.maxMagic			
	player:calcStat()			
	player:sendMinitext("Done!")


end



























