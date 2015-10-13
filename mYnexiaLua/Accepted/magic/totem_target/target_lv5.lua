
-- Type target lvl 5

---------------------------------------------------------------------------------------------

jujak_firestrom = {

on_learn = function(player) player.registry["learned_jujak_firestrom"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_firestrom"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 49
	local sound = 44
	
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
			target:sendMinitext(player.name.." hit you with Jujak Firestrom")
			player:sendMinitext("You cast Jujak Firestrom")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Jujak Firestrom")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 1 Dark Amber \n"
	txt = txt.."- 2000 Coins \n"

	local level = 74
	local item = {43, 18008, 0}
	local amounts = {100, 1, 2000}
	local desc = {"1 Target spell (Lv5)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



stormbringer = {

on_learn = function(player) player.registry["learned_stormbringer"] = 1 end,
on_forget = function(player) player.registry["learned_stormbringer"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 27
	local sound = 49

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
			target:sendMinitext(player.name.." hit you with Stormbringer")
			player:sendMinitext("You cast Stormbringer")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Stormbringer")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 1 Dark Amber \n"
	txt = txt.."- 2000 Coins \n"

	local level = 74
	local item = {43, 18008, 0}
	local amounts = {100, 1, 2000}
	local desc = {"1 Target spell (Lv5)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



baekho_deathsoul = {

on_learn = function(player) player.registry["learned_baekho_deathsoul"] = 1 end,
on_forget = function(player) player.registry["learned_baekho_deathsoul"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 44
	local sound = 54
	
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
			target:sendMinitext(player.name.." hit you with Baekho Deathsoul")
			player:sendMinitext("You cast Baekho Deathsoul")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Baekho Deathsoul")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 1 Dark Amber \n"
	txt = txt.."- 2000 Coins \n"

	local level = 74
	local item = {43, 18008, 0}
	local amounts = {100, 1, 2000}
	local desc = {"1 Target spell (Lv5)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



calamity_of_chungryong = {

on_learn = function(player) player.registry["learned_calamity_of_chungryong"] = 1 end,
on_forget = function(player) player.registry["learned_calamity_of_chungryong"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 31
	local sound = 59
	
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
			target:sendMinitext(player.name.." hit you with Calamity of chungryong")
			player:sendMinitext("You cast Calamity of chungryong")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Calamity of chungryong")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 1 Dark Amber \n"
	txt = txt.."- 2000 Coins \n"

	local level = 74
	local item = {43, 18008, 0}
	local amounts = {100, 1, 2000}
	local desc = {"1 Target spell (Lv5)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}
