omni = {

cast = function(player, target)

	if target.blType == BL_PC then
		if player:canPK(target) then
			if player:hasDuration("omni") then return else
				if player:hasDuration("shadow") then return else
					pc = target
					if r == 1 then player:warp(pc.m, pc.x, pc.y-1) player.side = 2 end	
					if r == 2 then player:warp(pc.m, pc.x, pc.y+1) player.side = 0 end	
					if r == 3 then player:warp(pc.m, pc.x-1, pc.y) player.side = 1 end	
					if r == 4 then player:warp(pc.m, pc.x+1, pc.y) player.side = 3 end
					player:sendSide()
					player:sendAction(1, 20)
					player:setDuration("omni", 7000)
				end
			end
		end
	end
end,


while_cast_125 = function(player)

	local r = math.random(1,4)
	local pc = player:getObjectsInArea(BL_PC)
	local x = math.random(player.x-2, player.x+2)
	local y = math.random(player.y-2, player.y+2)
	
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 2) then
				if player:canPK(pc[i]) then
					if pc[i].ID == player.ID then return else
						if r == 1 then player:warp(pc[i].m, pc[i].x, pc[i].y-1) player.side = 2 end
						if r == 2 then player:warp(pc[i].m, pc[i].x, pc[i].y+1) player.side = 0 end
						if r == 3 then player:warp(pc[i].m, pc[i].x-1, pc[i].y) player.side = 1 end
						if r == 4 then player:warp(pc[i].m, pc[i].x+1, pc[i].y) player.side = 3 end
						player:sendSide()
						player:sendAction(1, 20)
						player:sendAnimationXY(245, x, y)
					end
				end
			end
		end
	end
end,


uncast = function(player)

	player:calcStat()
end
}
					
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						