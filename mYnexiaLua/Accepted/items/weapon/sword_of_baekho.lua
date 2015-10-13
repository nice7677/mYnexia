

sword_of_baekho = {

on_swing = function(player)

	local facingmob = getTargetFacing(player, BL_MOB)
	local facingpc = getTargetFacing(player, BL_PC)
	local chance = math.random(1, 100)
	local damage = math.random(4000, 10000)
	
	if facingmob ~= nil or facingpc ~= nil then
		if chance <= 15 then
			mob = player:getObjectsInArea(BL_MOB)
			pc = player:getObjectsInArea(BL_PC)
			
			if #pc > 0 then
				for i = 1, #pc do
					if distanceSquare(player, pc[i], 3) then
						if player:canPK(pc[i]) and pc[i].state ~= 1 then
							if pc[i].ID ~= player.ID then
								pc[i].attacker = player.ID
								pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
								pc[i]:sendAnimationXY(43, pc[i].x, pc[i].y)
								pc[i]:sendAnimation(306)
								player:playSound(54)
							end
						end
					end
				end
			end
			
			if #mob > 0 then
				for i = 1, #mob do
					if distanceSquare(player, mob[i], 3) then
						if mob[i].owner == 0 then
							mob[i].attacker = player.ID
							mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
							mob[i]:sendAnimationXY(43, mob[i].x, mob[i].y)
							mob[i]:sendAnimation(306)
							player:playSound(54)
						end
					end
				end
			end
		end
	end
end,


strike = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)
	local damage = math.random(4000, 10000)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 3) then
				if mob[i].owner == 0 then
					mob[i].attacker = player.ID
					mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
					mob[i]:sendAnimationXY(43, mob[i].x, mob[i].y)
					mob[i]:sendAnimation(306)
					player:playSound(54)
				end
			end
		end
	end
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 3) then
				if player:canPK(pc[i]) and pc[i].state ~= 1 then
					pc[i].attacker = player.ID
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
					pc[i]:sendAnimationXY(43, pc[i].x, pc[i].y)
					pc[i]:sendAnimation(306)
					player:playSound(54)
				end
			end
		end
	end
end
}