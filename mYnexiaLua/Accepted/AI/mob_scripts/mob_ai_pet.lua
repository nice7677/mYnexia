mob_ai_pet = {

on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)
	
	local owner = mob:getBlock(mob.owner)
	
	mob.attacker = 0
	mob.target = 0
	mob:warp(owner.m, owner.x, owner.y)
	mob:sendAnimation(248)
end,

move = function(mob, target)
	
	local moved = true
	local pc = mob:getObjectsInArea(BL_PC)
	local block = mob:getBlock(mob.target)
	local owner = mob:getBlock(mob.owner)
	local facing = getTargetFacing(mob, BL_PC)

	if owner ~= nil then
		if #pc > 0 then
			for i = 1, #pc do
				if pc[i].ID == owner.ID then
					if pc[i].m == mob.m then
						if distanceSquare(mob, pc[i], 10) then
							mob.target = pc[i].ID
							moved = FindCoordsPet(mob, owner)
						end
					else
						mob:warp(pc[i].m, pc[i].x, pc[i].y)
						mob:sendAnimation(16)
						mob:playSound(29)
					end
				end
			end
		end
	end
end
}	
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			