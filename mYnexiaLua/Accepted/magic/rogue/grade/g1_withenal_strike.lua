withenal_strike = {

on_learn = function(player) player.registry["learned_withenal_strike"] = 1 end,
on_forget = function(player) player.registry["learned_withenal_strike"] = 0 end,

cast = function(player)
	
	local weap = player:getEquippedItem(EQ_WEAP)
	if weap ~= nil and weap.yname == "wooden_bow" then
		withenal_strike_bow.cast(player)
		return
	end
	
	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	local d = player.health *1.3
	local healthCost = player.health*.5
	local magicCost = 1000
	local threat
	
	if player.registry["combo1"] >= os.time() then
		player.registry["combo1"] = 0
		combo2.cast(player)
		return
	else
		player.registry["combo1"] = 0
		if (not player:canCast(1, 1, 0)) then return end
		if player.magic < magicCost then notEnoughMP(player) return end
		if(player.side==0) then player:sendAnimationXY(7, player.x, player.y-1) end
		if(player.side==1) then player:sendAnimationXY(7, player.x+1, player.y) end
		if(player.side==2) then player:sendAnimationXY(7, player.x, player.y+1) end
		if(player.side==3) then player:sendAnimationXY(7, player.x-1, player.y) end
	
		player:sendAction(1, 20)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(14)
		player:talk(2, "Crash~!!!")
		player:sendMinitext("You cast Withenal Strike.")
		
		if mob ~= nil then
			mob.attacker = player.ID
			threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
			player:addThreat(mob.ID, threat)
			mob:sendAnimation(331)
			mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
		elseif pc ~= nil then
			if player:canPK(pc) then
				pc.attacker = player.ID
				pc:sendAnimation(331)
				pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
				pc:sendMinitext(player.name.. " attack you with Withenal Strike!")
			end
		end
	end
end
}

---------------------------------------------------------------------------------------------------------------

combo2 = {
cast = function(player)
	
	local chance = math.random(100)
	local heal = player.baseHealth*.1
	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	local d = player.health*.5 + player.magic *.5
	local threat
	
	if (not player:canCast(1, 1, 0)) then return end
	if(player.side==0) then player:sendAnimationXY(7, player.x, player.y-1) end
	if(player.side==1) then player:sendAnimationXY(7, player.x+1, player.y) end
	if(player.side==2) then player:sendAnimationXY(7, player.x, player.y+1) end
	if(player.side==3) then player:sendAnimationXY(7, player.x-1, player.y) end
	
	player:sendAction(1, 20)	
	player:playSound(14)	
	player:talk(2, "!!~Combo~!!")
	player.registry["combo2"] = os.time()+1
	
	if mob ~= nil then
		if chance > 90 then player:sendAnimation(63) player:addHealth(heal) end
		mob.attacker = player.ID
		threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
		player:addThreat(mob.ID, threat)
		mob:sendAnimation(331)
		mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
	elseif pc ~= nil then
		if player:canPK(pc) then
			if chance > 90 then player:sendAnimation(63) player:addHealth(heal) end
			pc.attacker = player.ID
			pc:sendAnimation(331)
			pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
			pc:sendMinitext(player.name.. " attack you with Combo Strike!!")
		end
	end
end
}























		