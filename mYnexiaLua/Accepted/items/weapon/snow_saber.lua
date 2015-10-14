
snow_saber = {

on_swing = function(player)

	snow_saber.cast(player)
	
end,

cast = function(player)
	
	if player:hasAether("snow_saber") then return end
	
	player:setAether("snow_saber", 5000)
	for i = 1, 2 do
		sendFrontAnimation(player, 22, i)
		pc = getTargetFacing(player, BL_PC, 0, i)
		mob = getTargetFacing(player, BL_MOB, 0, i)
		if pc ~= nil then
			if player:canPK(pc) and pc.state ~= 1 then
				pc.attacker = player.ID
				pc:removeHealthExtend(math.random(1500,2000), 1,1,1,1,0)
				pc:sendAnimation(52)
				player:playSound(47)
				if pc:hasDuration("snow_saber") then return else pc:setDuration("snow_saber", 3000) end
				return
			end
		end
		if mob ~= nil then
			mob.attacker = player.ID
			mob:removeHealthExtend(math.random(1500, 2000), 1,1,1,1,0)
			mob:sendAnimation(52)
			player:playSound(47)
			if mob:hasDuration("snow_saber") then return else mob:setDuration("snow_saber", 3000) end
			return
		end
	end
end,

while_cast = function(player)

	player.speed = 200
	player:updateState()
end,

uncast = function(player)
	
	player:calcStat()
	player:updateState()
end

}




sendFrontAnimation = function(player, anim, cell)
	
	if tonumber(cell) == nil then cell = 0 end
	local s = player.side
	local x = player.x
	local y = player.y
	local m = player.m
	
	if s == 0 then
		player:sendAnimationXY(anim, x, y-cell)
	elseif s == 1 then
		player:sendAnimationXY(anim, x+cell, y)
	elseif s == 2 then
		player:sendAnimationXY(anim, x, y+cell)
	elseif s == 3 then
		player:sendAnimationXY(anim, x-cell, y)
	end
end