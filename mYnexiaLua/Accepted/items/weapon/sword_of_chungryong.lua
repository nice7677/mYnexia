sword_of_chungryong = {

on_swing = function(player)

	local pc = getTargetFacing(player, BL_PC)
	local mob = getTargetFacing(player, BL_MOB)
	local r = math.random(100)

	if r >= 90 then
		if pc ~= nil then
			if player:canPK(pc) and pc.state ~= 1 then
				sword_of_chungryong.spell(player, pc)
			end
		elseif mob ~= nil then
			sword_of_chungryong.spell(player, mob)
		end
	end
end,

spell = function(player, target)

	local damage = math.random(18000, 20000)

	if target.state == 1 then return false end
	
	target.attacker = player.ID
	target:removeHealthExtend(damage, 1,1,1,1,0)
	target:sendAnimationXY(150, target.x, target.y)
	target:sendAnimation(306)
	for i = 1, 2 do player:playSound(59) end
end
}