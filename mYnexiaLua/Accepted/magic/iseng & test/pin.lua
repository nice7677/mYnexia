

pin = {

cast = function(player)
	
	if player:hasDuration("pin") then return else
		player:setDuration("pin", 5000)
	end
	
end,

while_cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 3) then
				pin.warp(player, mob[1], math.random(0, 3))
			end
		end
	end
end,

warp = function(player, target, side)

	if side == 0 then
		if getPass(target.m, target.x, target.y-1) == 1 then return else
			player:warp(target.m, target.x, target.y-1)
			player.side = 2
			player:talk(0, "Up")
		end
	elseif side == 1 then
		if getPass(target.m, target.x+1, target.y) == 1 then return else
			player:warp(target.m, target.x+1, target.y)
			player.side = 3
			player:talk(0, "Right")
		end
	elseif side == 2 then
		if getPass(target.m, target.x, target.y+1) == 1 then return else
			player:warp(target.m, target.x, target.y+1)
			player.side = 0
			player:talk(0, "Down")
		end
	elseif side == 3 then
		if getPass(target.m, target.x-1, target.y) == 1 then return else
			player:warp(target.m, target.x-1, target.y)
			player.side = 1
			player:talk(0, "Left")
		end
	end
	player:sendSide()

end
}
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
				