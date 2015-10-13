monyet_event = {

cast = function(player, question)

	local q = string.lower(player.question)
	
	if q == "a" then
		player:spawn(50002, player.x, player.y, 1)
	elseif q == "b" then
		player:spawn(50002, player.x, player.y, 1)
	elseif q == "c" then
		player:spawn(50002, player.x, player.y, 1)
	end
	
	player:sendAction(6, 20)
end,


move = function(mob, target)
	
	local moved = true
	local pc
	
	if mob.paralyzed == true then return else
		for i = 1, 7 do
			pc = getTargetFacing(mob, BL_PC, 0, i)
			if pc ~= nil then
				throw_banana.cast(mob)
			end
		end
		
		pc = mob:getObjectsInArea(BL_PC)
		if #pc > 0 then
			for i = 1, #pc do
				if distanceSquare(mob, pc[i], 10) then
					if pc[i].state ~= 1 then
						mob.target = pc[i].ID
						moved=FindCoordsPet(mob, pc[i])
					end
				end
			end
		end
	end
end,

on_attacked = function(mob)

	mob.attacker = 0
	mob.target = 0
end

}




	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	