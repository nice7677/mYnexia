

sticky_paper = {

use = function(player)
	
	player:sendAction(7, 20)
	player:sendMinitext("You use Sticky paper.")
	player:playSound(6)	
	
	if player:hasDuration("sticky_paper") then
		anim(player)
		return
	else
		sticky_paper.cast(player)
	end
end,

cast = function(player)
	
	local pc = getTargetFacing(player, BL_PC)
	local mob = getTargetFacing(player, BL_MOB)
	local side = player.side
	
	if pc ~= nil then
		if player.m >= 10002 and player.m <= 10006 or player.m == 10022 then
			player:warp(pc.m, pc.x, pc.y)
			player:setDuration("sticky_paper", 15000)
			return
		else
			player:warp(pc.m, pc.x, pc.y)
			player:setDuration("sticky_paper", 15000)
			if side == 0 then
				pc:warp(pc.m, pc.x, pc.y+1)
			elseif side == 1 then
				pc:warp(pc.m, pc.x-1, pc.y)
			elseif side == 2 then
				pc:warp(pc.m, pc.x, pc.y-1)
			elseif side == 3 then
				pc:warp(pc.m, pc.x+1, pc.y)
			end
		end
		pc:sendMinitext(player.name.." use Sticky paper on you")
	end
	if mob ~= nil then
		if player.m >= 10002 and player.m <= 10006 or player.m == 10022 then return end
		player:warp(mob.m, mob.x, mob.y)
		player:setDuration("sticky_paper", 15000)
		if side == 0 then
			mob:warp(mob.m, mob.x, mob.y+1)
		elseif side == 1 then
			mob:warp(mob.m, mob.x-1, mob.y)
		elseif side == 2 then
			mob:warp(mob.m, mob.x, mob.y-1)
		elseif side == 3 then
			mob:warp(mob.m, mob.x+1, mob.y)
		end
	end
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	