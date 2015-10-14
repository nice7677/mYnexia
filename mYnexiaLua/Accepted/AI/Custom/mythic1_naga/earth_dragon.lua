
earth_dragon = {

move = function(mob, target)
	
	local chance = math.random(100)
	local pc = mob:getObjectsInMap(mob.m, BL_PC)
	local damage = math.random(50000, 80000)
	
	if mob.paralyzed == true or mob.sleep ~= 1 then return end
	if chance <= 5 then
		if #pc > 0 then
			for i = 1, #pc do
				t = pc[math.random(#pc)].ID
				if Player(t) ~= nil and Player(t).state ~= 1 then
					Player(t).attacker = mob.ID
					Player(t):removeHealthExtend(damage, 1,1,1,1,0)
					Player(t):sendAnimation(43)
					Player(t):playSound(59)
				end
			end
		end
	end
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)

	local chance = math.random(100)
	local pc = mob:getObjectsInMap(mob.m, BL_PC)
	local damage = math.random(50000, 80000)
	
	if mob.paralyzed == true or mob.sleep ~= 1 then return end
	if chance <= 2 then
		if #pc > 0 then
			for i = 1, #pc do
				t = pc[math.random(#pc)].ID
				if Player(t) ~= nil and Player(t).state ~= 1 then
					Player(t).attacker = mob.ID
					Player(t):removeHealthExtend(damage, 1,1,1,1,0)
					Player(t):sendAnimation(43)
					Player(t):playSound(59)
				end
			end
		end
	end
	mob_ai_basic.attack(mob, target)
end,

on_attacked = function(mob, attacker)

	mob_ai_basic.on_attacked(mob, attacker)
end

}