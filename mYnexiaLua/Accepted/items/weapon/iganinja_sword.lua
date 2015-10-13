iganinja_sword = {
on_swing = function(player)
	
	local pc = player:getObjectsInArea(BL_PC)
	local mob = player:getObjectsInArea(BL_MOB)

	if not player:hasDuration("iganinja_sword") and not player:hasAether("iganinja_sword") then
		if #mob > 0 then
			iganinja_sword.cast(player)
		elseif #pc > 0 then
			for i = 1, #pc do
				if player:canPK(pc[i]) and pc[i].state ~= 1 then
					iganinja_sword.cast(player)
				end
			end
		end
	end
end,

cast = function(player)

	player:setDuration("iganinja_sword", 6000)
	player:setAether("iganinja_sword", 25000)
end,

while_cast_250 = function(player)

	local pc = player:getObjectsInArea(BL_PC)
	local mob = player:getObjectsInArea(BL_MOB)
	local r = math.random(5)
	local anim = {6,7,9}
	local damage = (player.maxDam*2) +  math.random(500, 1000)
	local threat
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 2) then
				if mob[i].state == 1 then return end
				if r == 1 then
					player:warp(mob[i].m, mob[i].x-1, mob[i].y)
					player.side = 1
				elseif r == 2 then	
					player:warp(mob[i].m, mob[i].x+1, mob[i].y)
					player.side = 3
				elseif r == 3 then	
					player:warp(mob[i].m, mob[i].x, mob[i].y-1)
					player.side = 2
				elseif  r == 4 then	
					player:warp(mob[i].m, mob[i].x, mob[i].y+1)
					player.side = 0
				end
				player:playSound(358)				
				player:sendSide()
				player:swing()
				
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	elseif #pc > 0 then
		for i = 1, #pc do
			if pc[i].ID ~= player.ID then
				if player:canPK(pc[i]) then
					if distanceSquare(player, pc[i], 2) then
						if pc[i].state == 1 then return end	
						if r == 1 then
							player:warp(pc[i].m, pc[i].x-1, pc[i].y)
							player.side = 1
						elseif r == 2 then	
							player:warp(pc[i].m, pc[i].x+1, pc[i].y)
							player.side = 3
						elseif r == 3 then	
							player:warp(pc[i].m, pc[i].x, pc[i].y-1)
							player.side = 2
						elseif  r == 4 then	
							player:warp(pc[i].m, pc[i].x, pc[i].y+1)
							player.side = 0
						end
						player:playSound(358)
						player:sendSide()
						player:swing()
						pc[i].attacker = player.ID
						pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
				--		if r > 3 then player:sendAnimationXY(9, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1)) end
				--		if r < 3 then player:sendAnimationXY(7, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1)) end
				--		player:sendAnimationXY(279, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1))					
				--		player:sendAnimationXY(285, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1))
					end
				end
			end
		end
	end
	
	local r = math.random(6	)

	if r < 3 then player:sendAnimationXY(9, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1)) end
	if r > 3 then player:sendAnimationXY(7, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1)) end
	player:sendAnimationXY(279, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1))
	player:sendAnimationXY(285, math.random(player.x-1, player.x+1), math.random(player.y-1, player.y+1))	
	player:sendAnimationXY(279, player.x, player.y)	
	
end,

uncast = function(player)

	player:calcStat()
	
end
}
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
				
				