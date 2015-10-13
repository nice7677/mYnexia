cyclone = {

on_learn = function(player) player.registry["learned_cyclone"] = 1 end,
on_forget = function(player) player.registry["learned_cyclone"] = 0 end,


cast = function(player, target)

	local dam = math.random(player.minDam, player.maxDam) *3.5
	local magicCost = 7000
	local threat
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAction(1, 20)
	player:sendAnimation(283, player.x, player.y)
	player:playSound(91)
	player:playSound(501)
	player:setAether("cyclone", 15000)
	
	local pc = player:getObjectsInArea(BL_PC)
	local mob = player:getObjectsInArea(BL_MOB)

	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 3) then
				mob[i]:sendAnimation(245)
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(dam, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(dam, 1,1,1,1,0)
				if not mob[i]:hasDuration("cyclone") then mob[i]:setDuration("cyclone", 7000) end
			end
		end
	elseif #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 3) then
				if player:canPK(pc[i]) then
					if pc[i].ID ~= player.ID then	
						pc[i]:sendAnimation(245)
						pc[i].attacker = player.ID
						pc[i]:removeHealthExtend(dam, 1,1,1,1,0)
						pc[i]:sendMinitext(player.name.." attack you with Cyclone")
						if not pc[i]:hasDuration("cyclone") then pc[i]:setDuration("cyclone", 7000) end
					end
				end
			end
		end
	end
	player:sendMinitext("You cast Cyclone")
end,

on_walk_while_cast = function(player)
	
	local dam = player.health*.01
	
	player:removeHealth(dam)
	player:sendStatus()
	player:sendAnimation(301)
	player:playSound(104)
end,

uncast = function(player)

	player:calcStat()
end
}























