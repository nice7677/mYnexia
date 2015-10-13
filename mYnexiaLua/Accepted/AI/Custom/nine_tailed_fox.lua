

nine_tailed_fox = {

on_spawn = function(mob)

	pc = mob:getObjectsInMap(mob.m, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].state == 1 then return else
				mob:talk(2, mob.name..": Human?? delicious!")
			end
		end
	end
end,



on_attacked = function(mob, attacker)
	
	local r = math.random(1, 10)
	local health = mob.maxHealth*.5
	local health2 = health*.5
	
	if r <= 2 then
		if mob.health <= health and mob.health > health2 then
			mob:sendAnimation(20)
			mob:playSound(28)
			mob:sendHealth(0,0)
		elseif mob.health <= health2 then
			mob:sendAnimation(65)
			mob:playSound(98)
			mob:addHealthExtend(attacker.damage*2, 1,1,1,1,0)
		end
		return
	elseif r == 10 then
		mob:talk(2, mob.name..": Die~!!!")
		mob:playSound(83)
		attacker:sendAnimationXY(16, attacker.x, attacker.y)
		mob:playSound(29)
		mob:spawn(math.random(29,32), mob.x, mob.y, 3)
		get = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_MOB)
		if #get > 0 then
			for i = 1, #get do
				get[i].registry["sementara"] = get[i].ID
				get[i].attacker = attacker.ID
				get[i].target = attacker.ID
			end
		end
	end

	mob_ai_basic.on_attacked(mob, attacker)
end,




on_healed = function(mob, healer)

	mob_ai_basic.on_healed(mob, healer)
end,


move = function(mob, target)

	local r = math.random(10)
	local target = mob:getBlock(mob.target)
	local damage = math.floor(mob.damage*math.random(1,2))
	local foxes = mob:getObjectsInArea(BL_MOB)
	
	if mob:hasDuration("paralyzed") then
		mob:setDuration("paralyed", 0)
	end
	mob.paralyed = false
	
	if #foxes > 0 then
		for i = 1, #foxes do
			if distanceSquare(mob, foxes[i], 4) then
				if foxes[i].health <= 500 then
					if r <= 4 then
						foxes[i]:sendAnimation(5)
						foxes[i]:playSound(3)
						foxes[i]:addHealthExtend(math.random(250, 350), 1,1,1,1,0)
					end
				end
			end
		end
	end
	
	if mob.target ~= nil then
		if target.state ~= 1 then
			if not distanceSquare(mob, target, 4) then
				mob:playSound(725)
				target:sendAnimationXY(177, target.x, target.y)
				mob:warp(target.m, target.x, target.y)
				mob:playSound(81)
				mob.target = target.ID
				mob.attacker = target.ID
				if r <= 3 then mob:talk(2, mob.name..": You can't run from me!!") end
				if r > 3 and r <= 5 then mob:talk(2, mob.name..": Die~!!") end
				if r > 5 and r <= 8 then mob:talk(2, mob.name..": Think you can run after disturbing me?") end
			end
		end
	end
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	
	local r = math.random(10)
	local damage = mob.damage

	if r <= 3 then
		target.attacker = mob.ID
		target:sendAnimation(32)
		mob:playSound(1)
		target:removeHealthExtend(damage, 1,1,1,1,2)
	end	
	
	mob_ai_basic.attack(mob, target)
	
end
}