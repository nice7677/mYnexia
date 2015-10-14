

sho_spirit = {

cast = function(player)
	
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local healthCost = player.health*.5
	local magicCost = 5000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player.health = player.health - healthCost
	player:sendStatus()
	player:setAether("sho_spirit", 60000)
	
	local pc1 = getFrontTarget(player, 1, BL_PC)
	local pc2 = getFrontTarget(player, 2, BL_PC)
	local pc3 = getFrontTarget(player, 3, BL_PC)
	
	local mob1 = getFrontTarget(player, 1, BL_MOB)
	local mob2 = getFrontTarget(player, 2, BL_MOB)
	local mob3 = getFrontTarget(player, 3, BL_MOB)

	if mob1 == nil then
		if mob2 == nil then
			if mob3 == nil then
				sho_spirit.warp(player, 3)
				return
			else
				sho_spirit.takeDamage(mob3, player)
				sho_spirit.warp(player, 2)
				return
			end
		else
			sho_spirit.takeDamage(mob2, player)
			sho_spirit.warp(player, 1)
			return
		end
	else
		sho_spirit.takeDamage(mob1, player)
		sho_spirit.warp(player, 0)
		return
	end
	
	if pc1 == nil then
		if pc2 == nil then
			if pc3 == nil then
				sho_spirit.warp(player, 3)
				return
			else
				if player:canPK(pc3) and pc3.state ~= 1 then sho_spirit.takeDamage(pc3, player) end
				sho_spirit.warp(player, 2)
				return
			end
		else
			if player:canPK(pc2) and pc2.state ~= 1 then sho_spirit.takeDamage(pc2, player) end
			sho_spirit.warp(player, 1)
			return
		end
	else
		if player:canPK(pc1) and pc1.state ~= 1 then sho_spirit.takeDamage(pc1, player) end
		sho_spirit.warp(player, 0)
		return
	end
end,

takeDamage = function(target, player)
	
	local damage = player.health*1.2
	
	target.attacker = player.ID
	target:removeHealthExtend(damage, 1,1,1,1,0)
	target:sendAnimation(97)
	target:sendAnimation(423)
	player:playSound(349)
end,

warp = function(player, cell)

	if player.side == 0 then
		if getPass(player.m, player.x, player.y-cell) == 1 then return else player:warp(player.m, player.x, player.y-cell) end
	elseif player.side == 1 then
		if getPass(player.m, player.x+cell, player.y) == 1 then return else player:warp(player.m, player.x+cell, player.y) end
	elseif player.side == 2 then
		if getPass(player.m, player.x, player.y+cell) == 1 then return else player:warp(player.m, player.x, player.y+cell) end
	elseif player.side == 3 then
		if getPass(player.m, player.x-cell, player.y) == 1 then return else player:warp(player.m, player.x-cell, player.y) end
	end
	player:sendAction(1, 20)
	player:playSound(101)
	if player.side == 0 then
		player:sendAnimationXY(153, player.x, player.y-1)
	elseif player.side == 1 then
		player:sendAnimationXY(153, player.x+1, player.y)
	elseif player.side == 2 then
		player:sendAnimationXY(153, player.x, player.y+1)
	elseif player.side == 3 then
		player:sendAnimationXY(153, player.x-1, player.y)
	end
	player:talk(2, "Sho Spirit~!!!")
end
}
	
	
	

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	