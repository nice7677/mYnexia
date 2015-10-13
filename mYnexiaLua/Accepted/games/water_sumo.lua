

water_sumo = {

push = function(player)

	local pc = getTargetFacing(player, BL_PC)
	local m = player.m
	local x = player.x
	local y = player.y
	
	if m == 1000 then
		if y >= 117 and y <= 124 then
			if x >= 65 and x <= 75 then
				if pc ~= nil and pc.state ~= 1 then
					if pc.registry["can_be_push"] == 0 then
						water_sumo.canPush(player, pc)
					else
						pushBack(player)
					end
				end
			end
		end
	end
end,

canPush = function(player, target)
	
	local atas = target:getObjectsInCell(target.m, target.x, target.y-1, BL_PC)
	local bawah = target:getObjectsInCell(target.m, target.x, target.y+1, BL_PC)
	local kiri = target:getObjectsInCell(target.m, target.x-1, target.y, BL_PC)
	local kanan = target:getObjectsInCell(target.m, target.x+1, target.y, BL_PC)
	local r = math.random(1,2)
	
	if target.state == 1 then return false end
	local pc = getTargetFacing(player, BL_PC)
	
	if pc ~= nil and pc.ID == target.ID then
		if player.side == 0 then
			if #atas == 0 then
				target:warp(target.m, target.x, target.y-1)
			else
				if r == 1 then target:warp(target.m, target.x-1, target.y) end 
				if r == 2 then target:warp(target.m, target.x+1, target.y) end
			end
			
		elseif player.side == 1 then
			if #kanan == 0 then
				target:warp(target.m, target.x+1, target.y)
			else
				if r == 1 then target:warp(target.m, target.x, target.y-1) end 
				if r == 2 then target:warp(target.m, target.x, target.y+1) end
			end
		elseif player.side == 2 then
			if #bawah == 0 then
				target:warp(target.m, target.x, target.y+1)
			else
				if r == 1 then target:warp(target.m, target.x-1, target.y) end 
				if r == 2 then target:warp(target.m, target.x+1, target.y) end
			end
		elseif player.side == 3 then
			if #kiri == 0 then
				target:warp(target.m, target.x-1, target.y)
			else
				if r == 1 then target:warp(target.m, target.x, target.y-1) end 
				if r == 2 then target:warp(target.m, target.x, target.y+1) end
			end
		end
		target:sendAnimation(191)
		player:playSound(10)
		tile = getTile(target.m, target.x, target.y)
		if tile >= 118 and tile <= 123 then
			player:sendAction(10, 60)
			player:playSound(73)			
			target:talk(2, "Die")
			target.state = 1
			target:updateState()
			target:sendAnimationXY(137, target.x, target.y)
			target:sendAnimation(142)
			player:broadcast(1000, "[Water sumo]  "..target.name.." has defeated by "..player.name.." at water sumo area")
			player:giveXP(1500000)
			water_sumo.respawn(target)
		end
	end
end,


respawn = function(player)

	if player.m == 1000 then
		if player.y >= 117 and player.y <= 124 then
			if player.x >= 65 and player.x <= 75 then
				if player.state == 1 then
					if player:hasDuration("water_sumo") then return else
						player:setDuration("water_sumo", 5000)
					end
				end
			end
		end
	end
end,

while_cast = function(player)
	
	local sec = player:getDuration("water_sumo")
	sec = countDownSeconds(sec)
	
	player:talk(2, "Respawn in : "..sec)
end,

uncast = function(player)

	if player.state == 1 then
		player:warp(1000, 65, 127)
		player.side = 1
		player:sendAnimation(425)
		player:playSound(112)
		player.state = 0
		player:updateState()
		player:sendSide()
	end
end
}