mob_ai_ghost = {

on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob,target)

	local found
	local moved=true
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
	
	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
	else
		if (mob.owner == 0 or mob.owner > 1073741823) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then target = block end
		end
	
		if (mob.state ~= MOB_HIT and target == nil and mob.owner == 0) then
			c1 = math.random(0, 20)
			c2 = math.random(0, 10)
			if c1 == 0 then mob.side = 0 end
			if c1 == 1 then mob.side = 1 end
			if c1 == 2 then mob.side = 2 end
			if c1 == 3 then mob.side = 3 end
			mob:sendSide()
			if c1 < c2 then
				if (not mob.snare and not mob.blind) then moved=mob:moveGhost() end
			end
		else
			local owner = mob:getBlock(mob.owner)
		
			if (target == nil and owner ~= nil) then
				target = mob:getBlock(owner.target)
				mob.target = owner.target
			end
			
			if (target ~= nil) then
				if (not mob.snare and not mob.blind) then
					moved=FindCoordsGhost(mob,target)
				end
				
				if((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner) then
					mob.state = MOB_HIT
				end
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack=function(mob,target)

	local moved
	
	if (target) then
		threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=FindCoordsGhost(mob,target)
		if(moved and mob.target ~= mob.owner) then
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end
}
