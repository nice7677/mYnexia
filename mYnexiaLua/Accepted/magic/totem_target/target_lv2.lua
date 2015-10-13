
-- Type target lvl 2

---------------------------------------------------------------------------------------------

jujak_inferno = {

on_learn = function(player) player.registry["learned_jujak_inferno"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_inferno"] = 0 end,

cast = function(player, target)
	
	local magicCost = 100
	local damage = player.wisdom*.5 + math.random(500, 1000)
	local threat
	local anim = 46
	local sound = 41
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end
	
	if target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6, 20)
			target.attacker = player.ID
			target:sendAnimation(anim)
			player:playSound(sound)
			target:removeHealthExtend(damage, 1,1,1,1,0)
			target:sendMinitext(player.name.." hit you with Jujak Inferno")
			player:sendMinitext("You cast Jujak Inferno")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Jujak Inferno")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Ink \n"

	local level = 16
	local item = {43, 18144}
	local amounts = {50, 1}
	local desc = {"1 Target spell (Lv2)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



hyunmoo_deathrain = {

on_learn = function(player) player.registry["learned_hyunmoo_deathrain"] = 1 end,
on_forget = function(player) player.registry["learned_hyunmoo_deathrain"] = 0 end,

cast = function(player, target)
	
	local magicCost = 100
	local damage = player.wisdom*.5 + math.random(500, 1000)
	local threat
	local anim = 24
	local sound = 46

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end
	
	if target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6, 20)
			target.attacker = player.ID
			target:sendAnimation(anim)
			player:playSound(sound)
			target:removeHealthExtend(damage, 1,1,1,1,0)
			target:sendMinitext(player.name.." hit you with Hyunmoo Deathrain")
			player:sendMinitext("You cast Hyunmoo Deathrain")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Hyunmoo Deathrain")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Ink \n"

	local level = 16
	local item = {43, 18144}
	local amounts = {50, 1}
	local desc = {"1 Target spell (Lv2)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



baekho_disaster = {

on_learn = function(player) player.registry["learned_baekho_disaster"] = 1 end,
on_forget = function(player) player.registry["learned_baekho_disaster"] = 0 end,

cast = function(player, target)
	
	local magicCost = 100
	local damage = player.wisdom*.5 + math.random(500, 1000)
	local threat
	local anim = 41
	local sound = 51
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end
	
	if target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6, 20)
			target.attacker = player.ID
			target:sendAnimation(anim)
			player:playSound(sound)
			target:removeHealthExtend(damage, 1,1,1,1,0)
			target:sendMinitext(player.name.." hit you with Baekho Disaster")
			player:sendMinitext("You cast Baekho Disaster")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Baekho Disaster")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Ink \n"

	local level = 16
	local item = {43, 18144}
	local amounts = {50, 1}
	local desc = {"1 Target spell (Lv2)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



chung_thunderbolt = {

on_learn = function(player) player.registry["learned_chung_thunderbolt"] = 1 end,
on_forget = function(player) player.registry["learned_chung_thunderbolt"] = 0 end,

cast = function(player, target)
	
	local magicCost = 100
	local damage = player.wisdom*.5 + math.random(500, 1000)
	local threat
	local anim = 28
	local sound = 56
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end
	
	if target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6, 20)
			target.attacker = player.ID
			target:sendAnimation(anim)
			player:playSound(sound)
			target:removeHealthExtend(damage, 1,1,1,1,0)
			target:sendMinitext(player.name.." hit you with Chung Thunderbolt")
			player:sendMinitext("You cast Chung Thunderbolt")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Chung Thunderbolt")
	end
end,

requirements = function(player)

	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Ink \n"

	local level = 16
	local item = {43, 18144}
	local amounts = {50, 1}
	local desc = {"1 Target spell (Lv2)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}
