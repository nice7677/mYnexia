ashura_strike = {

cast = function(player, target)
	
	if not player:canCast(1,1,0) then return end
	if player:hasDuration("ashura_strike") then return end
	
	if target.blType == BL_PC then
		if player:canPK(target) and target.state ~= 1 then
			if distanceSquare(player, target, 3) then
				player.registry["ashura_target"] = target.ID
				player:setDuration("ashura_strike", 3000)
				player:sendAction(3, 500)
				player:sendAnimation(237)
				player:sendAnimation(403)
				player:playSound(60)
			else
				anim(player)
				player:sendMinitext("Target is out of range!")
			end
		end
	end
end,

while_cast = function(player)

	player:sendAnimation(344)
end,


while_cast_250 = function(player)
	
	player:sendAnimation(417)
	player:sendAnimation(237, math.random(player.x-2, player.x+2), math.random(player.y-2, player.y+2))
	player:sendAnimation(261, math.random(player.x-2, player.x+2), math.random(player.y-2, player.y+2))
	player:sendAnimation(262, math.random(player.x-2, player.x+2), math.random(player.y-2, player.y+2))
	player:sendAnimation(237, math.random(player.x-2, player.x+2), math.random(player.y-2, player.y+2))
	player:sendAnimation(232, math.random(player.x-2, player.x+2), math.random(player.y-2, player.y+2))

end,

uncast = function(player)
	
	local pc = Player(player.registry["ashura_target"])
	
	player.magic = 0
	player:sendStatus()
	
	if pc ~= nil and pc.m == player.m then
		if distanceSquare(player, pc, 3) then
			if player.x < pc.x then
				player:warp(player.m, pc.x+1, pc.y)
				player.side = 3
			end
			if player.x > pc.x then
				player:warp(player.m, pc.x-1, pc.y)
				player.side = 1
			end
			if player.y < pc.y then
				player:warp(player.m, pc.x, pc.y-1)
				player.side = 2
			end
			if player.y > pc.y then
				player:warp(player.m, pc.x, pc.y+1)
				player.side = 0
			end
			player:sendSide()
			pc:removeHealth(pc.health)
			pc:sendAnimation(192)
			pc:sendAnimation(423)			
			pc:sendAnimation(202)
			pc:sendAnimation(153)
			player:sendAnimation(267)
			player:sendAnimation(134)
			player:sendAnimation(149)
			player:playSound(54)
			player:playSound(45)
			player:playSound(59)
			for i = 1, 3 do player:playSound(509) player:playSound(20) end
		else
			anim(player)
			player:sendMinitext("Target is out of range!")
		end
	end
end
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		