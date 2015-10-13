soccer_ball = {


move = function(mob)

	if mob.m == 1000 then
		if mob.y >= 116 and mob.y <= 118 then
			if mob.x == 45 or mob.x == 46 then
	--			mob:sendAnimation(121)
				mob:talk(2, "Goal~!!!")
			elseif mob.x == 32 or mob.x == 33 then
	--			mob:sendAnimation(121)
				mob:talk(2, "Goal~!!!")
			end
		end
	end
end,
		

on_mount = function(player, mob)
	
	shoot.cast(player)
end,




while_cast = function(mob, caster)
	
	if caster ~= nil then
		mob:talk(2, "Goal by : "..caster.name)
	end
end,


uncast = function(player)
	
	local mob = Mob(player.registry["soccer_goal"])
	
	player:sendAction(10, 60)
	player:playSound(80)
	if mob ~= nil then
		mob:warp(1000, 39, 117)
		mob:sendAnimationXY(121, mob.x, mob.y)
	end
end
}





shoot = {

cast = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	
	if mob ~= nil and mob.yname == "soccer_ball" then
		if mob:hasDuration("shoot") then return else
			player:sendAction(1, 40)
			player:talk(2, "Shoot~!!!")
			mob:sendAnimation(300)
			player:playSound(1)
			mob:setDuration("shoot", 1000, player.ID, 1)
			if player.side == 0 then mob.registry["upWarp"] = 1 end
			if player.side == 1 then mob.registry["rightWarp"] = 1 end
			if player.side == 2 then mob.registry["downWarp"] = 1 end
			if player.side == 3 then mob.registry["leftWarp"] = 1 end
		end
	end
end,

while_cast_250 = function(block, caster)
	
	local up = block.registry["upWarp"]
	local down = block.registry["downWarp"]
	local right = block.registry["rightWarp"]
	local left = block.registry["leftWarp"]
	local pc = getTargetFacing(block, BL_PC)

	if pc ~= nil then block:setDuration("shoot", 0) return end

	if up == 1 and down == 0 and right == 0 and left == 0 then
		toXY(block, block.x, block.y-1)
	elseif down == 1 and up == 0 and right == 0 and left == 0 then
		toXY(block, block.x, block.y+1)
	elseif right == 1 and left == 0 and up == 0 and down == 0 then
		toXY(block, block.x+1, block.y)
	elseif left == 1 and right == 0 and up == 0 and down == 0 then
		toXY(block, block.x-1, block.y)
	end
end,

uncast = function(block)

	block.registry["upWarp"] = 0
	block.registry["downWarp"] = 0
	block.registry["rightWarp"] = 0
	block.registry["leftWarp"] = 0
	block:calcStat()
end
}


















