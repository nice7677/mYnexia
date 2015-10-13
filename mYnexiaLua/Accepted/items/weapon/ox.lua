
removeHealth = {

ox_sword = function(block, weap)
	
	local damage
	if weap == 0 then
		damage = math.random(60000, 80000)
	elseif weap == 2 then
		damage = math.random(70000, 90000)
	elseif weap == 1 then
		damage = math.random(80000, 100000)
	elseif weap == 8 then
		damage = math.random(90000, 110000)
	elseif weap == 12 then
		damage = math.random(100000, 120000)
	elseif weap == 6 then
		damage = math.random(110000, 130000)
	elseif weap == 11 then
		damage = math.random(120000, 140000)
	end
	block:removeHealthExtend(damage, 1,1,1,1,0)
	block:sendAnimation(114)
	for i = 1, 2 do block:playSound(118) end
	block:sendAnimation(245)
end
}


ox_sword = {

on_swing = function(player)

	local chance = math.random(100)
	
	if chance <= 20 then
		for i = 1, 8 do
			pc = getTargetFacing(player, BL_PC,0,i)
			mob = getTargetFacing(player, BL_MOB,0,i)
			weap = player:getEquippedItem(EQ_WEAP)
			if weap ~= nil then
				if pc ~= nil then
					if player:canPK(pc) and pc.state ~= 1 then
						pc.attacker = player.ID
						removeHealth.ox_sword(pc, weap.lookC)
						return
					end
				end
				if mob ~= nil then
					if mob.owner == 0 then
						mob.attacker = player.ID
						removeHealth.ox_sword(mob, weap.lookC)
						return
					end
				end
			end
		end
	end
end
}


