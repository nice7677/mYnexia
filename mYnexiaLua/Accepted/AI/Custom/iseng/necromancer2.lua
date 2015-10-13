
necromancer2 = {

on_healed = function(mob, healer)

	mob_ai_basic.on_healed(mob, healer)
	
end,


move = function(mob, target)

	local pc = mob:getObjectsInMap(mob.m, BL_PC)
	
	if #pc > 0 then
		for i = 1, #pc do
			mob.attacker = pc[i].ID
			mob.target = pc[i].ID
			mob.state = MOB_HIT
		end
	end
	
end,

attack=function(mob,target)
	local moved
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	if (target) then
		threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=FindCoords(mob,target)
		if(moved and mob.target ~= mob.owner) then
			--We are right next to them, so attack!
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end
}