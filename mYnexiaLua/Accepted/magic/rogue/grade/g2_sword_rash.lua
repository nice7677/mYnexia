sword_rash = {

on_learn = function(player) player.registry["learned_sword_rash"] = 1 end,
on_forget = function(player) player.registry["learned_sword_rash"] = 0 end,

cast = function(player)
	
	local weap = player:getEquippedItem(EQ_WEAP)
	if weap ~= nil and weap.yname == "wooden_bow" then
		sword_rash_bow.cast(player)
		return
	end	
	
	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	local d = player.health *.5 + player.magic*.5
	local healthCost = player.health*.5
	local magicCost = 1000
	local threat
	
	if player.registry["combo2"] >= os.time() then
		player.registry["combo2"] = 0
		combo3.cast(player)
		return
	else
		player.registry["combo2"] = 0
		if (not player:canCast(1, 1, 0)) then return end
		if player.magic < magicCost then notEnoughMP(player) return end
		if(player.side==0) then player:sendAnimationXY(68, player.x, player.y-1) end
		if(player.side==1) then player:sendAnimationXY(68, player.x+1, player.y) end
		if(player.side==2) then player:sendAnimationXY(68, player.x, player.y+1) end
		if(player.side==3) then player:sendAnimationXY(68, player.x-1, player.y) end
	
		player:sendAction(1, 20)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(91)
		player:talk(2, "Die You~!!!")
		player:setAether("sword_rash", 15000)
		player:sendMinitext("You cast Sword Rash")
		
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
				pc:sendMinitext(player.name.. " attack you with Sword Rash")
			end
		end
	end
end
}
------------------------------------------------------------------------------------------------------

combo3 = {
cast = function(player)
	
	local chance = math.random(100)
	local heal = player.baseHealth*.1
	local d = player.health*.5 + player.magic *.5
	local threat
	local mob = getTargetFacing(player, BL_MOB)
	local pc = getTargetFacing(player, BL_PC)
	
	if (not player:canCast(1, 1, 0)) then return end
	if(player.side==0) then player:sendAnimationXY(68, player.x, player.y-1) end
	if(player.side==1) then player:sendAnimationXY(68, player.x+1, player.y) end
	if(player.side==2) then player:sendAnimationXY(68, player.x, player.y+1) end
	if(player.side==3) then player:sendAnimationXY(68, player.x-1, player.y) end
		
	player:sendAction(1, 20)	
	player:playSound(91)
	player:talk(2, "!!!~Combo~!!!")
	player.registry["combo3"] = os.time()+1
	
	if mob ~= nil then
		if chance > 90 then player:sendAnimation(237) player:addHealth(heal) end
		mob.attacker = player.ID
		threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
		player:addThreat(mob.ID, threat)
		mob:sendAnimation(331)
		mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
	elseif pc ~= nil then
		if player:canPK(pc) then
			if chance > 90 then player:sendAnimation(237) player:addHealth(heal) end
			pc.attacker = player.ID
			pc:sendAnimation(331)
			pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
			pc:sendMinitext(player.name.. " attack you with Combo Strike!!!")
		end
	end
end
}



