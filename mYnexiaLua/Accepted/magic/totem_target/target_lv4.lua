
-- Type target lvl 4

---------------------------------------------------------------------------------------------

jujak_abomination = {

on_learn = function(player) player.registry["learned_jujak_abomination"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_abomination"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.ID == player.ID then return end
	
	if target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6, 20)
			target.attacker = player.ID
			target:sendAnimation(48)
			player:playSound(43)
			target:removeHealthExtend(damage, 1,1,1,1,0)
			target:sendMinitext(player.name.." attack you with Jujak Abomination")
			player:sendMinitext("You cast Jujak Abomination")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(48)
		player:playSound(43)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Jujak Abomination")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Iron Saber \n"
	txt = txt.."- 500 Coins \n"

	local level = 45
	local item = {43, 3034, 0}
	local amounts = {50, 1, 500}
	local desc = {"1 Target spell (Lv4)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



hyun_blizzard = {

on_learn = function(player) player.registry["learned_hyun_blizzard"] = 1 end,
on_forget = function(player) player.registry["learned_hyun_blizzard"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 26
	local sound = 48
	
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
			target:sendMinitext(player.name.." attack you with Hyun Blizzard")
			player:sendMinitext("You cast Hyun Blizzard")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Hyun Blizzard")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Iron Saber \n"
	txt = txt.."- 500 Coins \n"

	local level = 45
	local item = {43, 3034, 0}
	local amounts = {50, 1, 500}
	local desc = {"1 Target spell (Lv4)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



baekho_in_hell = {

on_learn = function(player) player.registry["learned_baekho_in_hell"] = 1 end,
on_forget = function(player) player.registry["learned_baekho_in_hell"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 43
	local sound = 53
	
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
			target:sendMinitext(player.name.." attack you with Baekho In Hell")
			player:sendMinitext("You cast Baekho In Hell")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Baekho In Hell")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Iron Saber \n"
	txt = txt.."- 500 Coins \n"

	local level = 45
	local item = {43, 3034, 0}
	local amounts = {50, 1, 500}
	local desc = {"1 Target spell (Lv4)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}



---------------------------------------------------------------------------------------------



chungryong_cyclone = {

on_learn = function(player) player.registry["learned_chungryong_cyclone"] = 1 end,
on_forget = function(player) player.registry["learned_chungryong_cyclone"] = 0 end,

cast = function(player, target)
	
	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 30
	local sound = 58
	
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
			target:sendMinitext(player.name.." attack you with Chungryong Cyclone")
			player:sendMinitext("You cast Chungryong Cyclone")
		end
	elseif target.blType == BL_MOB then
		player:sendAction(6, 20)
		target:sendAnimation(anim)
		player:playSound(sound)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		player:sendMinitext("You cast Chungryong Cyclone")
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 50 Chesnut \n"
	txt = txt.."- 1 Iron Saber \n"
	txt = txt.."- 500 Coins \n"

	local level = 45
	local item = {43, 3034, 0}
	local amounts = {50, 1, 500}
	local desc = {"1 Target spell (Lv4)", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}
