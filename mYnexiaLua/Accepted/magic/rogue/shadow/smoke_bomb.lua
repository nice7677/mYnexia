


smoke_bomb = {

cast = function(player)

	local pc = player:getObjectsInArea(BL_PC)
	local magicCost = 3000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:setAether("smoke_bomb", 60000)
	player:sendAction(6, 40)
	player.magic = player.magic - magicCost
	player:sendStatus()
	
	for i = 1, 2 do player:playSound(73) end
	
	player:sendAnimationXY(292, player.x-3, player.y-1)
	player:sendAnimationXY(292, player.x-2, player.y-2)
	player:sendAnimationXY(292, player.x-1, player.y-3)
	player:sendAnimationXY(292, player.x+1, player.y-3)
	player:sendAnimationXY(292, player.x+2, player.y-2)
	player:sendAnimationXY(292, player.x+3, player.y-1)
	player:sendAnimationXY(292, player.x+3, player.y+1)
	player:sendAnimationXY(292, player.x+2, player.y+2)
	player:sendAnimationXY(292, player.x+1, player.y+3)
	player:sendAnimationXY(292, player.x-1, player.y+3)
	player:sendAnimationXY(292, player.x-2, player.y+2)
	player:sendAnimationXY(292, player.x-3, player.y+1)
	
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 3) then
				if pc[i].state ~= 0 then return else
					pc[i].state = 2
					pc[i]:updateState()
					if pc[i].ID ~= player.ID then
						pc[i]:sendMinitext(player.name.." cast smoke bomb on you!")
					end
					pc[i]:setDuration("smoke_bomb", 15000)
				end
			end
		end
	end
	
	player:sendMinitext("You cast Smoke bomb")
end,

uncast = function(player)
	
	player:calcStat()
	if player.state == 2 then
		player.state = 0
		player:updateState()
	end
end,

on_swing_while_cast = function(player)

	player:setDuration("smoke_bomb", 0)
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	