

eye_of_storm = {

cast = function(player)

	if not player:canCast(1,1,0) then return end
	
	player:sendAction(6, 20)
	if player:hasDuration("eye_of_storm") then
		player:setDuration("eye_of_storm", 0)
	return else
		local magicCost = 15000
		player:setDuration("eye_of_storm", 20000)
	end
end,

while_cast_125 = function(player)

	player.magic = player.magic - 15000
	player:sendStatus()
	if player.magic < 15000 or player.magic - 15000 < 0 then
		player:setDuration("eye_of_storm", 0)
	end
end,

while_cast = function(player)

	local pc = player:getObjectsInArea(BL_PC)
	local mob = player:getObjectsInArea(BL_MOB)
	
	player:sendAnimation(290)
	player:playSound(math.random(50, 53))
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 3) then
				mob[i].attacker = player.ID
				mob[i].paralyzed = true
				mob[i]:setDuration("stun", 2000)
				mob[i]:sendAnimation(420)
				mob[i]:sendAnimation(143)
			end
		end
	end
	
	if #pc > 0 then
		for i = 1, #pc do
			if pc[i].ID ~= player.ID then
				if player:canPK(pc[i]) then
					if distanceSquare(player, pc[i], 3) then
						pc[i].attacker = player.ID
						pc[i].sleep = 2
						pc[i]:setDuration("stun", 2000)
						pc[i]:sendAnimation(420)
						pc[i]:sendAnimation(143)
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

						
						
stun = {

while_cast_250 = function(block)
	
	if block.blType == BL_PC then
		block.sleep = 2
	elseif block.blType == BL_MOB then
		block.paralyzed = true
	end
end,

uncast = function(block)

	block:calcStat()
	if block.blType == BL_PC then
		block.sleep = 1
	elseif block.blType == BL_MOB then
		block.paralyzed = false
	end
end
}
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		