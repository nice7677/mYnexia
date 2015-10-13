
-- Lv 1

jujak_holyfire = {

on_learn = function(player) player.registry["learned_jujak_holyfire"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_holyfire"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)
	local threat
	local damage = player.wisdom*.5 + math.random(70, 80)
	
	local magicCost = 80
	local sound = 40
	local anim = 45
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Jujak holyfire")
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
					pc[i]:sendMinitext(player.name.." attack you with Jujak holyfire")
				end
			end
		end
	end
end
}
				
	
----------------------------------------------------------------------------------------------------------------	
-- Lv 2	
	
jujak_fireclaw = {

on_learn = function(player) player.registry["learned_jujak_fireclaw"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_fireclaw"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 100
	local damage = player.wisdom*.5 + math.random(500, 1000)
	local threat
	local anim = 46
	local sound = 41
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Jujak fireclaw")
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
					pc[i]:sendMinitext(player.name.." attack you with Jujak fireclaw")
				end
			end
		end
	end
end
}	
	
-------------------------------------------------------------------------------------------------------------------
-- Lv 3

jujak_hellraiser = {

on_learn = function(player) player.registry["learned_jujak_hellraiser"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_hellraiser"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 200
	local damage = player.wisdom*.5 + math.random(1000, 2000)
	local threat
	local anim = 47
	local sound = 42
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Jujak hellraiser")
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
					pc[i]:sendMinitext(player.name.." attack you with Jujak hellraiser")
				end
			end
		end
	end
end
}		
	

-------------------------------------------------------------------------------------------------------------------
-- Lv 4
	
jujak_bloodfire = {

on_learn = function(player) player.registry["learned_jujak_bloodfire"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_bloodfire"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 500
	local damage = player.wisdom*.5 + math.random(3000, 5000)
	local threat
	local anim = 48
	local sound = 43
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Jujak bloodfire")
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
					pc[i]:sendMinitext(player.name.." attack you with Jujak bloodfire")
				end
			end
		end
	end
end
}
	
--------------------------------------------------------------------------------------------------------------
-- LV 5	
	
	
jujak_massacre = {

on_learn = function(player) player.registry["learned_jujak_massacre"] = 1 end,
on_forget = function(player) player.registry["learned_jujak_massacre"] = 0 end,

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)

	local magicCost = 1000
	local damage = player.wisdom*.5 + math.random(4000, 6000)
	local threat
	local anim = 188
	local sound = 43
	
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Jujak massacre")
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
					pc[i]:sendMinitext(player.name.." attack you with Jujak massacre")
				end
			end
		end
	end
end
}
	
	
	
	