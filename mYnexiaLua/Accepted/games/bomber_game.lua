
bomber_game = {

cast = function(player)

	if player:hasDuration("bomber_game") then
		player:setDuration("bomber_game", 0)
	return else
		player:sendAnimation(248)
		player:setDuration("bomber_game", 120000)
		gfxClone(player, player)
		player.gfxWeap = 167
		player.gfxWeapC = 50
		player.gfxClone = 1
		player:updateState()
	end
end,


while_cast = function(player)

	local dura = player:getDuration("bomber_game")

	player.gfxWeap = 167
	player.gfxWeapC = 50
	player:sendAnimation(367)
	player:playSound(109)

	player:talk(2, "".. dura/1000 .." s")

	if dura == 2000 then
		player.paralyzed = true
		player:sendAction(12, 60)
		player:sendAnimation(19)
		player:sendAnimation(171)
	end
	
end,

uncast = function(player)
	
	player.paralyzed = false
	player.gfxClone = 0
	player:updateState()
	player.attacker = player.ID
	player:sendAnimation(172)
	player:sendAnimationXY(292, player.x, player.y)
	player:sendAnimationXY(188, player.x-1, player.y)
	player:sendAnimationXY(188, player.x+1, player.y)
	player:sendAnimationXY(188, player.x, player.y-1)
	player:sendAnimationXY(188, player.x, player.y+1)
	for i = 1, 3 do
		player:playSound(54)
		player:playSound(73)
		player:playSound(99)
	end
	player:removeHealth(player.health)
	player:sendAnimation(134)
	player:playSound(500)
	player:sendAnimation(245)
end,


on_swing_while_cast = function(player)
	
	local dura = player:getDuration("bomber_game")
	local m = player.m
	local x = player.x
	local y = player.y
	local side = player.side
	
	if player:hasDuration("bomber_game") then
		for i = 1, 2 do
			pc = getTargetFacing(player, BL_PC, 0, i)
			if side == 0 then
				player:throw(x,y-i, 275 , 0, 1)
			elseif side == 1 then
				player:throw(x+i,y, 275 , 0, 1)
			elseif side == 2 then
				player:throw(x,y+i, 275 , 0, 1)
			elseif side == 3 then
				player:throw(x-i,y, 275 , 0, 1)
			end
			if pc ~= nil and pc.state ~= 1 then
				player:talk(0, "Passed!")
				pc:sendAnimation(368)
				player.gfxClone = 0
				player:updateState()
				player:flushDurationNoUncast(41, 41)
				gfxClone(pc, pc)
				pc.gfxWeap = 167
				pc.gfxWeapC = 50
				pc.gfxClone = 1
				pc:setDuration("bomber_game", dura)
				pc:sendAnimation(248)
				pc:sendStatus()
				pc:updateState()
			end
		end
	end
end
}

			

bomber_start = {

uncast = function(player)

	local around = player:getObjectsInMap(player.m, BL_PC)
	
	bomber_game.cast(around[math.random(#around)])
end
			
}	
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
