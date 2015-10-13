gm_push = {
cast = function(player)

	local pc = getTargetFacing(player, BL_PC)
	
	if player.side == 0 then		
		player:sendAnimationXY(191, player.x, player.y-1)		
	elseif player.side == 1 then		
		player:sendAnimationXY(191, player.x+1, player.y)		
	elseif player.side == 2 then		
		player:sendAnimationXY(191, player.x, player.y+1)		
	elseif player.side == 3 then		
		player:sendAnimationXY(191, player.x-1, player.y)		
	end		
			
	if pc ~= nil then
		
		if pc.registry["can_be_push"] > 0 then
			anim(player)
			pushBack(player)
			player:popUp("Do not disturb!")
			return
		end	
		
		if pc:hasDuration("gm_push") then return else
			if player.side == 0 then
				pc.registry["gm_push0"] = 1
			elseif player.side == 1 then
				pc.registry["gm_push1"] = 1
			elseif player.side == 2 then
				pc.registry["gm_push2"] = 1
			elseif player.side == 3 then
				pc.registry["gm_push3"] = 1
			end
			pc:setDuration("gm_push", 7000)
		end
	end
	
	player:sendAction(1, 20)
	player:playSound(10)
end,

while_cast_125 = function(player)
	
	--player:sendAnimationXY(396, player.x, player.y)
	player:sendAnimationXY(86, player.x, player.y)
	player:playSound(94)
	
	if player.registry["gm_push0"] == 1 then
		if getPass(player.m, player.x, player.y-1) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x, player.y-1)
		end
	elseif player.registry["gm_push1"] == 1 then
		if getPass(player.m, player.x+1, player.y) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x+1, player.y)
		end
	elseif player.registry["gm_push2"] == 1 then
		if getPass(player.m, player.x, player.y+1) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x, player.y+1)
		end
	elseif player.registry["gm_push3"] == 1 then
		if getPass(player.m, player.x-1, player.y) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x-1, player.y)
		end
	end
end,

while_cast_250 = function(player)
	
	player:sendAnimationXY(191, player.x, player.y)
	
	if player.registry["gm_push0"] == 1 then
		if getPass(player.m, player.x, player.y-1) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x, player.y-1)
		end
	elseif player.registry["gm_push1"] == 1 then
		if getPass(player.m, player.x+1, player.y) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x+1, player.y)
		end
	elseif player.registry["gm_push2"] == 1 then
		if getPass(player.m, player.x, player.y+1) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x, player.y+1)
		end
	elseif player.registry["gm_push3"] == 1 then
		if getPass(player.m, player.x-1, player.y) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x-1, player.y)
		end
	end
end,

while_cast = function(player)

		if player.registry["gm_push0"] == 1 then
		if getPass(player.m, player.x, player.y-1) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x, player.y-1)
		end
	elseif player.registry["gm_push1"] == 1 then
		if getPass(player.m, player.x+1, player.y) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x+1, player.y)
		end
	elseif player.registry["gm_push2"] == 1 then
		if getPass(player.m, player.x, player.y+1) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x, player.y+1)
		end
	elseif player.registry["gm_push3"] == 1 then
		if getPass(player.m, player.x-1, player.y) == 1 then player:setDuration("gm_push", 0) return else
			player:warp(player.m, player.x-1, player.y)
		end
	end
end,	

uncast = function(player)

	player:calcStat()
	for i = 0, 3 do
		player.registry["gm_push"..i] = 0
	end	
end
}
	
