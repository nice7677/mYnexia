
ice_monster = {

after_death = function(mob)
	
	local rate = math.random(10)
	if rate <= 5 then
		mob:dropItem(18173, 1)
	end
	mob:sendAnimationXY(195, mob.x, mob.y)
	mob:playSound(59)

end,
	
on_attacked = function(mob, attacker)
		
	mob.attacker = 0
	mob:sendHealth(0, 0)
	ice_monster.move(mob, target)
end,

on_healed = function(mob, healer)
	
	mob.attacker = 0
	mob:sendHealth(0,0)
end,

move = function(mob, target)
	
	local rate = math.random(10)
	local target = mob:getBlock(mob.target)
	local tile = {18322, 18332, 18280, 18338, 18327}
	local pcAtas = mob:getObjectsInCell(mob.m, mob.x, mob.y-1, BL_PC)
	local pcBawah = mob:getObjectsInCell(mob.m, mob.x, mob.y+1, BL_PC)
	local pcKanan = mob:getObjectsInCell(mob.m, mob.x+1, mob.y, BL_PC)
	local pcKiri = mob:getObjectsInCell(mob.m, mob.x-1, mob.y, BL_PC)
	
	if #pcAtas > 0 then
		mob.side = 0
		ice_monster.hit(mob, pcAtas[math.random(#pcAtas)])
	elseif #pcBawah > 0 then
		mob.side = 2
		ice_monster.hit(mob, pcBawah[math.random(#pcBawah)])
	elseif #pcKanan > 0 then
		mob.side = 1 
		ice_monster.hit(mob, pcKanan[math.random(#pcKanan)])
	elseif #pcKiri > 0 then
		mob.side = 3
		ice_monster.hit(mob, pcKiri[math.random(#pcKiri)])
	end
	mob:sendSide()

	for i = 1, #tile do
		if getTile(mob.m, mob.x, mob.y) == tile[i] then
			mob:playSound(math.random(53,54))
			mob:sendAnimation(188)
			mob:removeHealth(5000000)
			if target ~= nil then
				if mob.registry["target"] == target.ID then
					mob.registry["mob_killer"] = target.ID
					moved = FindCoords(mob, target)
					mob:talk(2, mob.name..": Arghhhhh")
				end
			return else
				mob.registry["mob_killer"] = 0
			end
		end
	end
	
	if target ~= nil then
		if mob.registry["chase_target"] >= os.time() then
			if mob.registry["target"] == target.ID then
				if distanceSquare(mob, target, 3) then
					mob:sendAnimation(248)
					moved = FindCoords(mob, target)
					if (moved) and mob:moveIntent(target.ID) == 1 then mob.state = MOB_HIT end
				else
					mob:sendAnimation(318)
					mob.target = 0
					mob.state = MOB_ALIVE
					mob.registry["chase_target"] = 0
					mob.registry["mob_killer"] = 0
				end
			end
		return else
			mob:sendAnimation(318)
			mob.target = 0
			mob.state = MOB_ALIVE
			mob.registry["chase_target"] = 0
			mob.registry["mob_killer"] = 0
		end
	else
		pc = mob:getObjectsInArea(BL_PC)
		if #pc > 0 then
			for i = 1, #pc do
				if distanceSquare(mob, pc[i], 3) and pc[i].state ~= 1 then
					if pc[i].action == 19 then
						mob.registry["target"] = pc[i].ID
						mob.registry["chase_target"] = os.time()+5
						mob:sendAnimation(248)
						mob.target = pc[i].ID
						mob:talk(2, mob.name..": GRR!! ")
						return
					end
				end
			end
		end
		if rate <= 3 then
			c1 = math.random(0, 20)
			c2 = math.random(0, 10)
			if c1 <= 3 and c1 ~= 2  then mob.side = c1 end
			mob:sendSide()
			if c2 > c1 then mob:move() end
		end
	end
end,

attack = function(mob, target)

	local target = mob:getBlock(mob.target)
	
	if target == 0 then
		mob:sendAnimation(318)
		mob.state = MOB_ALIVE
		ice_monster.move(mob, target)
		return
	else
		if (target) then
			if mob.registry["target"] == target.ID then
				mob:sendAnimation(248)
				moved = FindCoords(mob, target)
				if (moved) or mob:moveIntent(target.ID) == 1 then
					ice_monster.hit(mob, target)
				else
					mob.state = MOB_ALIVE
				end
			end
		else
			mob.state = MOB_ALIVE
		end
	end
end,

hit = function(mob, target)
	
	if target.state == 1 then return end
	mob:sendAction(1, 60)
	mob:sendAnimation(164)
	mob:attack(target.ID)
	target:removeHealth(target.health)
	target:playSound(360)
	target:playSound(364)
	target:playSound(349)
	target:sendAnimation(423)
	target:sendAnimation(153)
end
}
	



























