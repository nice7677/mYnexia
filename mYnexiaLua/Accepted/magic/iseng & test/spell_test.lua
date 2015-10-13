

spell_test = {

cast = function(player, target)
	
	local attacker = player
	local ded = 1 * string.format("%.2f", target.armor / (target.armor + 400 + 95 * (attacker.level + attacker.tier^2 + attacker.mark^3)))
	
	if target:hasDuration("spell_test") then
--		target:setDuration("spell_test", 0)
		addHealth(target, 5000)
	return else
		target:setDuration("spell_test", 60000)
		
	end
	
end,


while_cast = function(player)
	
	if player.attacker >= 1073741823 then
		healer = Mob(player.attacker)
	elseif player.attacker > 0 then
		healer = Player(player.attacker)
	end
	player:talk(2, "My last attacker = "..healer.name.."")	
end,

uncast = function(player)

	player:calcStat()
end
}

	
	--[[
	if (sleep > 0 and print == 2) then
		amount = amount * player.sleep
	elseif (sleep == 1) then
		amount = amount * player.sleep
		player.sleep = 1
		player.updateState()
	elseif (sleep == 2) then
		amount = amount * player.sleep
	end
	
	if (deduction == 1) then
		if (player.deduction < 0) then
			amount = 0
		elseif (player.deduction > 0) then
			amount = amount * player.deduction
		end
	end
	
	if (ac == 1) then
		if (ded < .85) then
			amount = amount * (1 - ded)
		else
			amount = amount * .15
		end
	end
	
	if (ds > 0 and print == 2) then
		amount = amount - player.dmgShield
	elseif (ds == 1) then
		if (player.dmgShield > 0) then
			if (player.dmgShield > amount) then
				player.dmgShield = player.dmgShield - amount
				amount = 0
			else
				amount = amount - player.dmgShield
				player.dmgShield = 0
			end
		else
			amount = amount - player.dmgShield
			player.dmgShield = 0
		end
	elseif (ds == 2) then
		player.dmgShield = player.dmgShield - amount
	end
	
	if (attacker ~= nil) then
		attacker.damage = amount
		attacker.critChance = 0
	else
		player.damage = amount
		player.critChance = 0
	end
	
	if (print == 1) then
		if (player.health - amount <= 0) then
			player.health = 0
			player.state = 1
			player:updateState()
		else
			player.health = player.health - amount
			player:sendStatus()
		end
	elseif (print == 2) then
		return amount
	else
		player_combat.on_attacked(player, attacker)
		player:sendStatus()
	end			
				
		]]--		
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				