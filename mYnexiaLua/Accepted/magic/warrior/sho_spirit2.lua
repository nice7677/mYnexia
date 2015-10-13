sho_spirit2 = {

cast = function(player)

	local magicCost = 5000
	local damage = player.health*.7
	
	local m = player.m
	local x = player.x
	local y = player.y
	local s = player.side
	local mob, pc
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	mob = getTargetFacing(player, BL_MOB)
	pc = getTargetFacing(player, BL_PC)
	
	for i = 1, 3 do
		if s == 0 then
			if player:objectCanMoveFrom(x,y,0) then
				if getPass(m,x,y-i) == 0 and not getWarp(m,x,y-i) and player:objectCanMove(x,y-i,0) then
					player:warp(m,x,y-i)
				end
			end

		end
	end
	
	
end
}