
-- Type target lvl 3

---------------------------------------------------------------------------------------------

jujak_blaze = {

on_learn = function(player) player.registry["learned_jujak_blaze"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_blaze"] = 0 end,

cast = function(player, target)
	
	local magicCost = 200
	local damage = player.wisdom*.5 + math.random(1000, 2000)
	local threat
	local anim = 47
	local sound = 42

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
			target:sendMinitext(player.name.." attack you with Jujak Blaze")
			player:sendMinitext("You cast Jujak Blaze")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Jujak Blaze")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 70 Chesnut \n"
	txt = txt.."- 10 Tiger Meat \n"
	txt = txt.."- 50 Coins \n"

	local level = 31
	local item = {43, 55, 0}
	local amounts = {70, 10, 50}
	local desc = {"1 Target spell (Lv3)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



hyunmoo_blaspheme = {

on_learn = function(player) player.registry["learned_hyunmoo_blaspheme"] = 1 end,
on_forget = function(player) player.registry["learned_hyunmoo_blaspheme"] = 0 end,

cast = function(player, target)
	
	local magicCost = 200
	local damage = player.wisdom*.5 + math.random(1000, 2000)
	local threat
	local anim = 25
	local sound = 47

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
			target:sendMinitext(player.name.." attack you with Hyunmoo Blaspheme")
			player:sendMinitext("You cast Hyunmoo Blaspheme")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Hyunmoo Blaspheme")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 70 Chesnut \n"
	txt = txt.."- 10 Tiger Meat \n"
	txt = txt.."- 50 Coins \n"

	local level = 31
	local item = {43, 55, 0}
	local amounts = {70, 10, 50}
	local desc = {"1 Target spell (Lv3)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



baekho_cataclysm = {

on_learn = function(player) player.registry["learned_baekho_cataclysm"] = 1 end,
on_forget = function(player) player.registry["learned_baekho_cataclysm"] = 0 end,

cast = function(player, target)
	
	local magicCost = 200
	local damage = player.wisdom*.5 + math.random(1000, 2000)
	local threat
	local anim = 42
	local sound = 52
	
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
			target:sendMinitext(player.name.." attack you with Baekho Cataclysm")
			player:sendMinitext("You cast Baekho Cataclysm")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Baekho Cataclysm")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 70 Chesnut \n"
	txt = txt.."- 10 Tiger Meat \n"
	txt = txt.."- 50 Coins \n"

	local level = 31
	local item = {43, 55, 0}
	local amounts = {70, 10, 50}
	local desc = {"1 Target spell (Lv3)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



chungryong_slice = {

on_learn = function(player) player.registry["learned_chungryong_slice"] = 1 end,
on_forget = function(player) player.registry["learned_chungryong_slice"] = 0 end,

cast = function(player, target)
	
	local magicCost = 200
	local damage = player.wisdom*.5 + math.random(1000, 2000)
	local threat
	local anim = 29
	local sound = 57

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
			target:sendMinitext(player.name.." attack you with Chungryong Slice")
			player:sendMinitext("You cast Chungryong Slice")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Chungryong Slice")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 70 Chesnut \n"
	txt = txt.."- 10 Tiger Meat \n"
	txt = txt.."- 50 Coins \n"

	local level = 31
	local item = {43, 55, 0}
	local amounts = {70, 10, 50}
	local desc = {"1 Target spell (Lv3)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}
