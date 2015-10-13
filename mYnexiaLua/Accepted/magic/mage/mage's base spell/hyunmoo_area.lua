
-- Lv 1

hyun_deathstorm = {

on_learn = function(player) player.registry["learned_hyun_deathstorm"] = 1 end,
on_forget = function(player) player.registry["learned_hyun_deathstorm"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)
	local threat
	local damage = player.wisdom*.5 + math.random(70, 80)
	
	local magicCost = 80
	local anim = 23
	local sound = 45
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Hyun deathstorm")
	player:sendAnimationXY(anim, x, y)
	player:playSound(sound)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 2) then
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 2) and player:canPK(pc[i]) and pc[i].ID ~= player.ID then
				if pc[i].state == 1 then return else
					pc[i].attacker = player.ID
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:sendMinitext(player.name.." attack you with Hyun deathstorm")
				end
			end
		end
	end
end
}
				
	
----------------------------------------------------------------------------------------------------------------	
-- Lv 2	
	
hyun_ice_bomb = {

on_learn = function(player) player.registry["learned_hyun_ice_bomb"] = 1 end,
on_forget = function(player) player.registry["learned_hyun_ice_bomb"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 100
	local damage = player.wisdom*.5 + math.random(500, 1000)
	local threat
	local anim = 24
	local sound = 46
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Hyun ice bomb")
	player:sendAnimationXY(anim, x, y)
	player:playSound(sound)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 2) then
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 2) and player:canPK(pc[i]) and pc[i].ID ~= player.ID then
				if pc[i].state == 1 then return else
					pc[i].attacker = player.ID
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:sendMinitext(player.name.." attack you with Hyun ice bomb")
				end
			end
		end
	end
end
}	
	
-------------------------------------------------------------------------------------------------------------------
-- Lv 3

hyun_waterstorm = {

on_learn = function(player) player.registry["learned_hyun_waterstorm"] = 1 end,
on_forget = function(player) player.registry["learned_hyun_waterstorm"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 200
	local damage = player.wisdom*.5 + math.random(1000, 2000)
	local threat
	local anim = 25
	local sound = 47
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Hyun waterstorm")
	player:sendAnimationXY(anim, x, y)
	player:playSound(sound)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 2) then
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 2) and player:canPK(pc[i]) and pc[i].ID ~= player.ID then
				if pc[i].state == 1 then return else
					pc[i].attacker = player.ID
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:sendMinitext(player.name.." attack you with Hyun waterstorm")
				end
			end
		end
	end
end
}		
	

-------------------------------------------------------------------------------------------------------------------
-- Lv 4
	
hyun_death_ice = {

on_learn = function(player) player.registry["learned_hyun_death_ice"] = 1 end,
on_forget = function(player) player.registry["learned_hyun_death_ice"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 26
	local sound = 48
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Hyun death ice")
	player:sendAnimationXY(anim, x, y)
	player:playSound(sound)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 2) then
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 2) and player:canPK(pc[i]) and pc[i].ID ~= player.ID then
				if pc[i].state == 1 then return else
					pc[i].attacker = player.ID
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:sendMinitext(player.name.." attack you with Hyun death ice")
				end
			end
		end
	end
end
}
	
--------------------------------------------------------------------------------------------------------------
-- LV 5	
	
	
ice_storm = {

on_learn = function(player) player.registry["learned_ice_storm"] = 1 end,
on_forget = function(player) player.registry["learned_ice_storm"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 1000
	local damage = player.wisdom*.5 + math.random(4000, 6000)
	local threat
	local anim = 392
	local sound = 48
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Ice storm")
	player:sendAnimationXY(anim, x, y)
	player:playSound(sound)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 2) then
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 2) and player:canPK(pc[i]) and pc[i].ID ~= player.ID then
				if pc[i].state == 1 then return else
					pc[i].attacker = player.ID
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:sendMinitext(player.name.." attack you with Ice storm")
				end
			end
		end
	end
end
}
	
	
	
	