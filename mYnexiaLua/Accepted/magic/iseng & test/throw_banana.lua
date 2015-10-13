throw_banana = {
cast = function(block)
	
	local s = block.side
	local m = block.m
	local x = block.x
	local y = block.y
	
	block:sendAction(29, 20)
	
	if block.blType == BL_MOB then block.paralyzed = true end
	if block.blType == BL_PC then block.sleep = 2 end
	for i = 1, 7 do
		block:setDuration("throw_banana", 2000)
		if s == 0 then
			block:sendAnimationXY(367,x,y-i)
		elseif s == 1 then
			block:sendAnimationXY(367,x+i,y)
		elseif s == 2 then
			block:sendAnimationXY(367,x,y+i)
		elseif s == 3 then
			block:sendAnimationXY(367,x-i,y)
		end
	end
end,



while_cast_125 = function(player)
	
	local x = player.x
	local y = player.y
	
	for i = 1, 7 do
		if player.side == 0 then
			player:sendAnimationXY(367,x,y-i)
		elseif player.side == 1 then
			player:sendAnimationXY(367,x+i,y)
		elseif player.side == 2 then
			player:sendAnimationXY(367,x,y+i)
		elseif player.side == 3 then
			player:sendAnimationXY(367,x-i,y)
		end
	end
end,


uncast = function(block)

	player:calcStat()	
	if block.side == 0 then
		block:throw(block.x, block.y-i, 30, 0, 1)
	elseif block.side == 1 then
		block:throw(block.x+i, block.y, 30, 0, 1)
	elseif block.side == 2 then
		block:throw(block.x, block.y+i, 30, 0, 1)
	elseif block.side == 3 then
		block:throw(block.x-i, block.y, 30, 0, 1)
	end
	
	for i = 1, 7 do
		pc = getTargetFacing(block, BL_PC,0,i)
		if pc ~= nil then
			if pc.state == 4 or pc.state == 1 or pc:hasDuration("jadi_monyet") then return else
				pc:playSound(29)
				pc:sendAnimation(301)	
				pc.disguise = 268
				pc.state = 4
				pc:updateState()
				pc:setDuration("jadi_monyet", 30000)
				block:setDuration("jadi_monyet", 0)
			end
		end
	end
end
}

jadi_monyet = {

while_cast = function(player)
	
	player:talk(2, ""..player.name)
	player.disguise = 268
	player.state = 4
	player:sendAnimation(318)
end,

uncast = function(player)

	player.sleep = 0
	player:sendStatus()
	player:calcStat()
	
	if player.state == 4 then
		player.state = 0
		player:updateState()
	end
end
}
	
	
	
	
	
	
	
	
	
	