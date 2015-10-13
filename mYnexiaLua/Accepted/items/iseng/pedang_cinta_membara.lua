pedang_cinta_membara = {

while_equipped = function(player)

	player.attackSpeed = 5
	player:sendStatus()
end,

on_swing = function(player)
	
	local damage = 1000000 + math.random(5000, 1000000)
        local animid = 352
	for i = 1, 2 do player:playSound(500) end

	for i = 1, 7 do
		target = getTargetFacing(player, BL_PC, 0, i), getTargetFacing(player, BL_MOB, 0, i)
		if player.side == 0 then
			player:sendAnimationXY(animid, player.x, player.y-i)
		elseif player.side == 1 then
			player:sendAnimationXY(animid, player.x+i, player.y)
		elseif player.side == 2 then
			player:sendAnimationXY(animid, player.x, player.y+i)
		elseif player.side == 3 then
			player:sendAnimationXY(animid, player.x-i, player.y)
		end
		
		if target ~= nil then
			if target.blType == BL_PC then
				if player:canPK(target) then			
					target:removeHealth(damage)
                                        target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				end
			else
				target:sendAnimation(94)
				target:sendAnimation(403)
				target:removeHealth(damage)
                                target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			end
		end
	end
end
}
	
