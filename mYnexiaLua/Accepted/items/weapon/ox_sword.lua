
--[[
OXZ = {
on_swing = function(player)
	pcTarget = getTargetFacing(player, BL_PC)
	mobTarget = getTargetFacing(player, BL_MOB)
	
	local chance = math.random(100)
	local damage = math.random(player.maxDam*5, player.maxDam*6)
	
	
	if chance >= 85	 then
		if mobTarget ~= nil then
			player:swing()
			mobTarget:sendAnimation(114)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget:playSound(1)
			mobTarget:sendStatus()

		elseif pcTarget ~= nil and player:canPK(pcTarget) then
			player:swing()
			pcTarget:sendAnimation(114)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:playSound(1)
			pcTarget:sendStatus()

		end
	else
		return
	end
	
end
}------------------------------------- OX 5 --------------------------------------------------------

OX5 = {
on_swing = function(player)
	pcTarget = getTargetFacing(player, BL_PC)
	mobTarget = getTargetFacing(player, BL_MOB)

	local chance = math.random(100)
	local damage = math.random(player.maxDam*4, player.maxDam*5)
	
	
	if chance >= 85	 then
		if mobTarget ~= nil then
			player:swing()
			mobTarget:sendAnimation(114)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget:playSound(1)
			mobTarget:sendStatus()

		elseif pcTarget ~= nil and player:canPK(pcTarget) then
			player:swing()
			pcTarget:sendAnimation(114)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:playSound(1)
			pcTarget:sendStatus()

		end
	else
		return
	end
	
end
}------------------------------------- OX 4 --------------------------------------------------------

OX4 = {
on_swing = function(player)
	pcTarget = getTargetFacing(player, BL_PC)
	mobTarget = getTargetFacing(player, BL_MOB)

	local chance = math.random(100)
	local damage = math.random(player.maxDam*3, player.maxDam*4)
	
	
	if chance >= 85	 then
		if mobTarget ~= nil then
			player:swing()
			mobTarget:sendAnimation(114)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget:playSound(1)
			mobTarget:sendStatus()

		elseif pcTarget ~= nil and player:canPK(pcTarget) then
			player:swing()
			pcTarget:sendAnimation(114)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:playSound(1)
			pcTarget:sendStatus()

		end
	else
		return
	end
	
end
}-------------------------------------- OX 3 -------------------------------------------------------

OX3 = {
on_swing = function(player)
	pcTarget = getTargetFacing(player, BL_PC)
	mobTarget = getTargetFacing(player, BL_MOB)

	local chance = math.random(100)
	local damage = math.random(player.maxDam*2.5, player.maxDam*3.3)
	
	
	if chance >= 85	 then
		if mobTarget ~= nil then
			player:swing()
			mobTarget:sendAnimation(114)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget:playSound(1)
			mobTarget:sendStatus()
		elseif pcTarget ~= nil and player:canPK(pcTarget) then
			player:swing()
			pcTarget:sendAnimation(114)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:playSound(1)
			pcTarget:sendStatus()
		end
	else
		return
	end
	
end
}------------------------------------- OX  2 --------------------------------------------------------

OX2 = {
on_swing = function(player)
	pcTarget = getTargetFacing(player, BL_PC)
	mobTarget = getTargetFacing(player, BL_MOB)

	local chance = math.random(100)
	local damage = math.random(player.maxDam*2.7, player.maxDam*3.2)
	
	
	if chance >= 85	 then
		if mobTarget ~= nil then
			player:swing()
			mobTarget:sendAnimation(114)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget:playSound(1)
			mobTarget:sendStatus()
		elseif pcTarget ~= nil and player:canPK(pcTarget) then
			player:swing()
			pcTarget:sendAnimation(114)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:playSound(1)
			pcTarget:sendStatus()
		end
	else
		return
	end
	
end
}----------------------------------------- OX 1 ----------------------------------------------------

OX1 = {
on_swing = function(player)
	pcTarget = getTargetFacing(player, BL_PC)
	mobTarget = getTargetFacing(player, BL_MOB)

	local chance = math.random(100)
	local damage = math.random(player.maxDam*2, player.maxDam*2.7)
	
	
	if chance >= 85	 then
		if mobTarget ~= nil then
			player:swing()
			mobTarget:sendAnimation(114)
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mobTarget:playSound(1)
			mobTarget:sendStatus()
		elseif pcTarget ~= nil and player:canPK(pcTarget) then
			player:swing()
			pcTarget:sendAnimation(114)
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:playSound(1)
			pcTarget:sendStatus()
		end
	else
		return
	end
	
end
}-----------------------------------------------------------------------------------------------

]]--