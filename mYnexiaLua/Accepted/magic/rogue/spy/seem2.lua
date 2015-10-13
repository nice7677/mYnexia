seem = {

cast = function(player)

	pc = getTargetFacing(player, BL_PC)
	
	if player:hasDuration("seem") then return else
		if pc ~= nil then
			gfxClone(pc, player)
			player.gfxClone = 1
			player:updateState()
			player:setDuration("seem", 20000)
		end
	end
end,

while_cast_250 = function(player)

	player.gfxClone = 1
end,

uncast = function(player)

	player.gfxClone = 0
	player:updateState()
end
}