
onCast = function(player)

	local x = player.x
	local y = player.y
	local randtargetpc = player:getObjectsInArea(player.m, player.x, player.y, BL_PC)
	local randtargetmob = player:getObjectsInArea(player.m, player.x, player.y, BL_MOB)
	local rand = math.random(100)
	weap = player:getEquippedItem(EQ_WEAP)
	chance = math.random(100)

	if player.state == 2 then
		if player:hasDuration("shadow") then return else
			if player:hasDuration("invisible") then player:setDuration("invisible", 0) end
			player.state = 0
			player:updateState()
		end
	end

	if (player.confused) then
		if (rand <= 50) then
			player.target = randtargetpc[math.random(#randtargetpc)].ID
		elseif (rand > 50) then
			player.target = randtargetmob[math.random(#randtargetmob)].ID
		end
		player:sendMinitext("Your target has changed due to confusion!")
	end
	
	if weap ~= nil then
		pc = Player(player.target)
		mob = Mob(player.target)
		if weap.yname == "sadistic_staff" then
			if player:hasAether("sadistic_staff") then return end
			if player:canPK(pc) and pc.state ~= 1 and pc.ID ~= player.ID then
				sadistic_staff.effect(player, pc)
				player:setAether("sadistic_staff", 15000)
			elseif mob ~= nil and mob.owner == 0 then
				sadistic_staff.effect(player, mob)
				player:setAether("sadistic_staff", 15000)
			end
		elseif weap.yname == "death_brain" then
			if player:hasAether("death_brain") then return end
			if player:canPK(pc) and pc.state ~= 1 and pc.ID ~= player.ID then
				death_brain.effect(player, pc)
				player:setAether("death_brain", 15000)	
			elseif mob ~= nil and mob.owner == 0 then
				death_brain.effect(player, mob)
				player:setAether("death_brain", 15000)
			end
		end

		if chance <= 15 then
			if pc ~= nil and player:canPK(pc) and pc.state ~= 1 and pc.ID ~= player.ID then
				if weap.yname == "p7d" then
					p7d.poison(pc)
				elseif weap.yname == "ox_sword" then
					removeHealth.ox_sword(pc, weap.lookC)
				elseif weap.yname == "sword_of_chungryong" then
					sword_of_chungryong.spell(player, pc)
				elseif weap.yname == "sword_of_jujak" then
					sword_of_jujak.spell(player, pc)
				elseif weap.yname == "sword_of_baekho" then
					sword_of_baekho.strike(pc)
				elseif weap.yname == "kwansae_axe" then
					kwansae_axe.strike(pc)
				elseif weap.yname == "spear_of_stealth" then
					spear_of_stealth.cast(player)
				end
			end
			if mob ~= nil and mob.owner == 0 then
				if weap.yname == "p7d" then
					p7d.poison(mob)
				elseif weap.yname == "ox_sword" then
					removeHealth.ox_sword(mob, weap.lookC)
				elseif weap.yname == "sword_of_chungryong" then
					sword_of_chungryong.spell(player, mob)
				elseif weap.yname == "sword_of_jujak" then
					sword_of_jujak.spell(player, mob)
				elseif weap.yname == "sword_of_baekho" then
					sword_of_baekho.strike(mob)
				elseif weap.yname == "kwansae_axe" then
					kwansae_axe.strike(mob)
				elseif weap.yname == "spear_of_stealth" then
					spear_of_stealth.cast(player)
				end
			end
		end
	end
end