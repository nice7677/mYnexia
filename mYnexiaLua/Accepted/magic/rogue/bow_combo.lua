lethal_strike_bow = {
cast = function(player)
	
	local chance = math.random(100)
	local heal = player.baseHealth*.1
	local d = player.health*.03 + player.magic*.03
	local healthCost = player.health*.08
	local magicCost = 1000
	local threat

	if (not player:canCast(1, 1, 0)) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player:hasItem("arrow", 1) == true then
		player:removeItem("arrow", 1)
		player:sendAction(1, 20)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(90)
		player:setAether("lethal_strike", 1000)
		player.registry["combo1_bow"] = os.time()+1
		player:sendMinitext("You cast Lethal Strike")
		player:talk(2, "Strike~!!!")
		
		for i = 1, 8 do
			local mob = getTargetFacing(player, BL_MOB, 0, i)
			local pc = getTargetFacing(player, BL_PC, 0, i)	
			if mob ~= nil then
				if chance > 90 then player:sendAnimation(63) player:addHealth(heal) end
				mob.attacker = player.ID
				threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
				player:addThreat(mob.ID, threat)
				mob:sendAnimation(331)
				mob:sendAnimation(69)
				mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
				return
			elseif pc ~= nil then
				if player:canPK(pc) then
					if chance > 90 then player:sendAnimation(63) player:addHealth(heal) end
					pc.attacker = player.ID
					pc:sendAnimation(331)
					pc:sendAnimation(69)
					pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
					pc:sendMinitext(player.name.. " attack you with Lethal Strike!!")
					return
				end
			end
		end
	else
		anim(player)
		player:sendMinitext("Require an arrow")	
	end
end
}





withenal_strike_bow = {
cast = function(player)
	
	local d = player.health *.05
	local healthCost = player.health*.08
	local magicCost = 1000
	local threat
	
	if player.registry["combo1_bow"] >= os.time() then
		player.registry["combo1_bow"] = 0
		combo2_bow.cast(player)
		return
	else
		if player:hasItem("arrow", 1) == true then
			if (not player:canCast(1, 1, 0)) then return end
			if player.magic < magicCost then notEnoughMP(player) return end
			player.registry["combo1_bow"] = 0
			player:removeItem("arrow", 1)
			player:sendAction(1, 20)
			player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(14)
			player:talk(2, "Crash~!!!")
			player:sendMinitext("You cast Withenal Strike.")
		
			for i = 1, 7 do
				local mob = getTargetFacing(player, BL_MOB, 0, i)
				local pc = getTargetFacing(player, BL_PC, 0, i)
				if mob ~= nil then
					mob.attacker = player.ID
					threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
					player:addThreat(mob.ID, threat)
					mob:sendAnimation(331)
					mob:sendAnimation(7)
					mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
					return
				elseif pc ~= nil then
					if player:canPK(pc) then
						pc.attacker = player.ID
						pc:sendAnimation(331)
						pc:sendAnimation(7)
						pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
						pc:sendMinitext(player.name.. " attack you with Withenal Strike!")
						return
					end
				end
			end
		else
			anim(player)
			player:sendMinitext("Require an arrow")
		end
	end
end
}


combo2_bow = {
cast = function(player)
	
	local d = player.health *.05
	local threat
	
	player:sendAction(1, 20)
	player:playSound(14)
	player:talk(2, "!!~Combo~!!")
	player.registry["combo2_bow"] = os.time()+1
		
	for i = 1, 8 do
		local mob = getTargetFacing(player, BL_MOB, 0, i)	
		local pc = getTargetFacing(player, BL_PC, 0, i)
		if mob ~= nil then	
			mob.attacker = player.ID
			threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
			player:addThreat(mob.ID, threat)
			mob:sendAnimation(331)
			mob:sendAnimation(7)
			mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
			return			
		elseif pc ~= nil then	
			if player:canPK(pc) then	
				pc.attacker = player.ID	
				pc:sendAnimation(331)	
				pc:sendAnimation(7)	
				pc:removeHealthExtend(d, 1, 1, 1, 1, 0)	
				pc:sendMinitext(player.name.. " attack you with Combo!")
				return
			end	
		end	
	end	
end
}

sword_rash_bow = {
cast = function(player)
	
	local d = player.health *.03 + player.magic*.03
	local healthCost = player.health*.08
	local magicCost = 1000
	local threat
	
	if player.registry["combo2_bow"] >= os.time() then
		player.registry["combo2_bow"] = 0
		combo3_bow.cast(player)
		return
	else
		if player:hasItem("arrow", 1) == true then
			if (not player:canCast(1, 1, 0)) then return end
			if player.magic < magicCost then notEnoughMP(player) return end
			player.registry["combo2"] = 0
			player:removeItem("arrow", 1)
			player:sendAction(1, 20)
			player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(91)
			player:talk(2, "Die You~!!!")
			player:setAether("sword_rash", 15000)
			player:sendMinitext("You cast Sword Rash")
			
			for i = 1, 8 do
				local mob = getTargetFacing(player, BL_MOB, 0, i)
				local pc = getTargetFacing(player, BL_PC, 0, i)
				if mob ~= nil then
					mob.attacker = player.ID
					threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
					player:addThreat(mob.ID, threat)
					mob:sendAnimation(68)
					mob:sendAnimation(331)
					mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
					return
				elseif pc ~= nil then
					if player:canPK(pc) then
						pc.attacker = player.ID
						pc:sendAnimation(68)
						pc:sendAnimation(331)
						pc:removeHealthExtend(d, 1, 1, 1, 1, 0)
						pc:sendMinitext(player.name.. " attack you with Sword Rash")
						return
					end
				end
			end
		else
			anim(player)
			player:sendMinitext("Require an arrow")
		end
	end
end

}

combo3_bow = {
cast = function(player)
	
	local d = player.health *.03 + player.magic*.03
	local threat
	
	player.registry["combo3_bow"] = os.time()+1
	player:sendAction(1, 20)
	player:playSound(91)
	player:talk(2, "!!!~Combo~!!!")
	
	for i = 1, 8 do
		local mob = getTargetFacing(player, BL_MOB, 0, i)
		local pc = getTargetFacing(player, BL_PC, 0, i)
		if mob ~= nil then
			mob.attacker = player.ID
			threat = mob:removeHealthExtend(d, 1, 1, 1, 1, 2)
			player:addThreat(mob.ID, threat)
			mob:sendAnimation(68)
			mob:sendAnimation(331)
			mob:removeHealthExtend(d, 1, 1, 1, 1, 0)
			return
		elseif pc ~= nil then
			if player:canPK(pc) then	
				pc.attacker = player.ID
				pc:sendAnimation(68)
				pc:sendAnimation(331)
				pc:removeHealthExtend(d, 1, 1, 1, 1, 0)	
				pc:sendMinitext(player.name.. " attack you with Combo")	
				return
			end	
		end	
	end	
end
}


shadow_sword_bow = {
cast = function(player)

	local threat
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local dam = player.magic*.5 + player.health*.5
	local healthCost = player.health*.08
	local magicCost = 5000
		
	if player.registry["combo3_bow"] >= os.time() then
		player.registry["combo3_bow"] = 0
		combo4_bow.cast(player)
		return
	else
		if player:hasItem("arrow", 1) == true then
			if not player:canCast(1,1,0) then return end
			if player.magic < magicCost then notEnoughMP(player) return end
			player.registry["combo3_bow"] = 0
			player:removeItem("arrow", 1)
			player.magic = player.magic - magicCost
			player.health = player.health - healthCost
			player:sendStatus()
			
			for i = 1, 7 do
				local pc = getTargetFacing(player, BL_PC,0,i)
				local mob = getTargetFacing(player, BL_MOB,0,i)

				if s == 0 then
					player:sendAnimationXY(203,x,y-i)
				elseif s == 1 then
					player:sendAnimationXY(203,x+i,y)
				elseif s == 2 then
					player:sendAnimationXY(203,x,y+i)
				elseif s == 3 then
					player:sendAnimationXY(203,x-i,y)
				end
				
				if pc ~= nil then
					if player:canPK(pc) then
						pc:sendAnimation(331)
						pc:removeHealthExtend(dam, 1,1,1,1,0)
						pc.attacker = player.ID
						pc:sendMinitext(player.name.." attack you with Shadow Sword")
					end
				elseif mob ~= nil then
					mob.attacker = player.ID
					mob:sendAnimation(331)
					threat = mob:removeHealthExtend(dam, 1,1,1,1,2)
					player:addThreat(mob.ID, threat)
					mob:removeHealthExtend(dam,1,1,1,1,0)
				end
			end
			player:sendAction(1, 20)
			player:talk(2, "Shadow Sword~!!!")
			player:setAether("shadow_sword", 15000	)
		else
			anim(player)
			player:sendMinitext("Require an arrow")
		end
	end
end
}









combo4_bow = {
cast = function(player)

	local threat
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local dam = player.magic*.5 + player.health*.5
	
	for i = 1, 7 do	
		local pc = getTargetFacing(player, BL_PC,0,i)	
		local mob = getTargetFacing(player, BL_MOB,0,i)	

		if s == 0 then	
			player:sendAnimationXY(203,x,y-i)
		elseif s == 1 then	
			player:sendAnimationXY(203,x+i,y)
		elseif s == 2 then	
			player:sendAnimationXY(203,x,y+i)
		elseif s == 3 then
			player:sendAnimationXY(203,x-i,y)
		end	
		
		if pc ~= nil then
			if player:canPK(pc) then
				pc:sendAnimation(331)
				pc:removeHealthExtend(dam, 1,1,1,1,0)
				pc.attacker = player.ID
				pc:sendMinitext(player.name.." attack you with Shadow Sword")
			end
		elseif mob ~= nil then
			mob.attacker = player.ID
			mob:sendAnimation(331)
			threat = mob:removeHealthExtend(dam, 1,1,1,1,2)
			player:addThreat(mob.ID, threat)
			mob:removeHealthExtend(dam,1,1,1,1,0)
		end		
		
	end	
		
	player:sendAction(1, 20)
	player:talk(2, "!!!!~Combo~!!!!")
end
}


		
















		