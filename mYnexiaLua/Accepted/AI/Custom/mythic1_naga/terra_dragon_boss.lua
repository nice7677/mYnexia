terra_dragon_boss = {

on_healed = function(mob, healer)

	mob_ai_basic.on_healed(mob, healer)
	
end,

on_attacked = function(mob, attacker)

	mob_ai_basic.on_attacked(mob, attacker)
	
end,

move = function(mob, target)
	
	local found
	local moved = true
	local oldside = mob.side
	local checkmove = math.random(0,10)
	local block = mob:getBlock(mob.target)
	local r = math.random(0, 10)
	
	threat.calcHighestThreat(mob)
	if (block ~= nil) then target = block end
	
	if (mob.state ~= MOB_HIT and target == nil) then	
		local g = math.random(0, 10)
		local s = math.random(0, 10)
		if checkmove >= 4 then
			if s == 0 then mob.side = 0 end
			if s == 1 then mob.side = 1 end
			if s == 2 then mob.side = 2 end
			if s == 3 then mob.side = 3 end
			mob:sendSide()
			if g > 5 then moved=mob:move() end
		end
	else
		if (target ~= nil) then
			moved=FindCoords(mob,target)
			if (moved or mob:moveIntent(target.ID) == 1) then
				mob.state = MOB_HIT
			end
			if not distanceSquare(mob, target, 4) then
				if r <= 3 then terra_dragon_boss.skill1(target) end
			end
		end
	end
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack = function(mob, target)

	local moved
	local block = mob:getBlock(mob.target)
	
	if mob.target == 0 then
		mob.state = MOB_ALIVE
		terra_dragon_boss.move(mob, target)
		return
	end
	if (target) then
		threat.calcHighestThreat(mob)
		if (block ~= nil) then target = block end
		moved = FindCoords(mob, target)
		if (moved) then
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
	terra_dragon_boss.action(mob, target)
end,


action = function(mob, target)
	
	local r = math.random(10)
	
	if mob.target == 0 then
		mob.state = MOB_ALIVE
		terra_dragon_boss.move(mob, target)
		return
	end
	if r <= 3 then terra_dragon_boss.skill1(target) end
end,
	
	


skill1 = function(player)
	local x = player.x
	local y = player.y
	local m = player.m
	local damage = math.random(30000, 50000)
	local pc = player:getObjectsInArea(BL_PC)
	
	player:sendAnimationXY(361, x-2, y-2)
	player:sendAnimationXY(361, x-2, y-1)
	player:sendAnimationXY(361, x-2, y)
	player:sendAnimationXY(361, x-2, y+1)
	player:sendAnimationXY(361, x-2, y+2)
	player:sendAnimationXY(361, x-1, y+2)
	player:sendAnimationXY(361, x, y+2)
	player:sendAnimationXY(361, x+1, y+2)
	player:sendAnimationXY(361, x+2, y+2)
	player:sendAnimationXY(361, x+2, y+1)
	player:sendAnimationXY(361, x+2, y)
	player:sendAnimationXY(361, x+2, y-1)
	player:sendAnimationXY(361, x+2, y-2)
	player:sendAnimationXY(361, x+1, y-2)
	player:sendAnimationXY(361, x, y-2)
	player:sendAnimationXY(361, x-1, y-2)
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].state ~= 1 then
				if distanceSquare(player, pc[i], 2) then
					pc[i]:sendAnimation(43)
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:playSound(73)
				end
			end
		end
	end
end





















}	