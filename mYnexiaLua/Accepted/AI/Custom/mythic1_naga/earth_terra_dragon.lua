

earth_terra_dragon = {

on_healed = function(mob, healer)
	
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)

	mob_ai_basic.on_attacked(mob, attacker)
end,


move = function(mob, target)
	
	local pc = mob:getObjectsInMap(mob.m, BL_PC)

	if mob.sleep ~= 1 then return end
	if mob.registry[mob.yname] < os.time() then
		mob.registry[mob.yname] = os.time()+10
		if #pc > 0 then
			for i = 1, #pc do
				t = pc[math.random(#pc)].ID
				if Player(t) ~= nil and distanceSquare(mob, Player(t), 7) and Player(t).state ~= 1 then
					animationAround(Player(t), 361)
					Player(t):playSound(60)
					Player(t):addNPC(mob.yname, Player(t).x, Player(t).y, 500, 3000, mob.ID)
				end
			end
		end
	end
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)

	local pc = mob:getObjectsInMap(mob.m, BL_PC)

	if mob.sleep ~= 1 then return end
	if mob.registry[mob.yname] < os.time() then
		mob.registry[mob.yname] = os.time()+10
		if #pc > 0 then
			for i = 1, #pc do
				t = pc[math.random(#pc)].ID
				if Player(t) ~= nil and distanceSquare(mob, Player(t), 7) and Player(t).state ~= 1 then
					animationAround(Player(t), 361)
					Player(t):playSound(60)
					Player(t):addNPC(mob.yname, Player(t).x, Player(t).y, 500, 3000, mob.ID)
				end
			end
		end
	end
	mob_ai_basic.attack(mob, target)
end,

action = function(block, owner)

	animationAround(block, 361)
	
end,

endAction = function(block, owner)

	local damage = math.random(150000, 200000)
	local pc = block:getObjectsInArea(BL_PC)
	animationAround(block, 43)
	block:delete()
	if #pc > 0 then
		for i = 1, #pc do
			pc[i]:playSound(59)
			if pc[i].state ~= 1 and distanceSquare(block, pc[i], 2) then
				pc[i]:sendAnimation(332)
				pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
				pc[i]:setDuration("earth_terra_dragon", 3000)
				if pc[i]:hasDuration("earth_terra_dragon") then return else pc[i].blind = true end
			end
		end
	end
end,

cast = function(player, target)

	animationAround(target, 361)
	player:addNPC("earth_terra_dragon", target.m, target.x, target.y, 500, 3000, player.ID)
end,

while_cast = function(block) block.blind = true end,
uncast = function(block) block.blind = false end
}















