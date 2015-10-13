gm_push = {
cast = function(player)

	dura = player:getDuration("gm_push")
	player:setDuration("gm_push", dura + 2000)
	player.registry["gm_push_tile"] = player.registry["gm_push_tile"] + 1
	player:sendAction(3, 20)
	player:sendAnimation(33)
	player:playSound(17)	
end,

on_walk_while_cast = function(player)

	player:sendAnimation(246)
end,

uncast = function(player, target)

	local target = {getTargetFacing(player, BL_PC), getTargetFacing(player, BL_MOB)}
	
	if target ~= nil then
		for i = 0, #player.registry["gm_push_tile"] do
			pushBack(target)
		end
	end
end
}