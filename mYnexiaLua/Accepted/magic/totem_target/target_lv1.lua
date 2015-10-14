
-- Type target lvl 1

---------------------------------------------------------------------------------------------

jujak_fire = {

on_learn = function(player) player.registry["learned_jujak_fire"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_fire"] = 0 end,

cast = function(player, target)
	
	local magicCost = 80
	local damage = player.wisdom*.5 + math.random(70, 80)
	local threat
	local anim = 45
	local sound = 40
	
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
			target:sendMinitext(player.name.." attack you with Jujak Fire")
			player:sendMinitext("You cast Jujak Fire")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Jujak Fire")
	end
end,

requirements = function(player)

	local txt
	txt = "- 10 Chesnut \n"
	txt = txt.."- 1 Book \n"
	txt = txt.."- 10 Coins \n"
	
	local level = 6
	local item = {43, 18142, 0}
	local amounts = {10, 1, 10}
	local desc = {"1 Target spell (Lv1)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



hyunmoo_snow = {

on_learn = function(player) player.registry["learned_hyunmoo_snow"] = 1 end,
on_forget = function(player) player.registry["learned_hyunmoo_snow"] = 0 end,

cast = function(player, target)
	
	local magicCost = 80
	local damage = player.wisdom*.5 + math.random(70, 80)
	local threat
	local anim = 23
	local sound = 45
	
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
			target:sendMinitext(player.name.." attack you with Hyunmoo Snow")
			player:sendMinitext("You cast Hyunmoo Snow")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Hyunmoo Snow")
	end
end,

requirements = function(player)

	local txt
	txt = "- 10 Chesnut \n"
	txt = txt.."- 1 Book \n"
	txt = txt.."- 10 Coins \n"
	
	local level = 6
	local item = {43, 18142, 0}
	local amounts = {10, 1, 10}
	local desc = {"1 Target spell (Lv1)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



baekho_surge = {

on_learn = function(player) player.registry["learned_baekho_surge"] = 1 end,
on_forget = function(player) player.registry["learned_baekho_surge"] = 0 end,

cast = function(player, target)
	
	local magicCost = 80
	local damage = player.wisdom*.5 + math.random(70, 80)
	local threat
	local anim = 40
	local sound = 50
	
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
			target:sendMinitext(player.name.." attack you with Baekho Surge")
			player:sendMinitext("You cast Baekho Surge")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Baekho Surge")
	end
end,

requirements = function(player)

	local txt
	txt = "- 10 Chesnut \n"
	txt = txt.."- 1 Book \n"
	txt = txt.."- 10 Coins \n"
	
	local level = 6
	local item = {43, 18142, 0}
	local amounts = {10, 1, 10}
	local desc = {"1 Target spell (Lv1)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



chungryong_ray = {

on_learn = function(player) player.registry["learned_chungryong_ray"] = 1 end,
on_forget = function(player) player.registry["learned_chungryong_ray"] = 0 end,

cast = function(player, target)
	
	local magicCost = 80
	local damage = player.wisdom*.5 + math.random(70, 80)
	local threat
	local anim = 27
	local sound = 55
	
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
			target:sendMinitext(player.name.." attack you with Chungryong Ray")
			player:sendMinitext("You cast Chungryong Ray")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Chungryong Ray")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 10 Chesnut \n"
	txt = txt.."- 1 Book \n"
	txt = txt.."- 10 Coins \n"
	
	local level = 6
	local item = {43, 18142, 0}
	local amounts = {10, 1, 10}
	local desc = {"1 Target spell (Lv1)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}
