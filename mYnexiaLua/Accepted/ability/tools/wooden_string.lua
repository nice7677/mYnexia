
wooden_string = {


on_swing = function(player)

	local obj = getObjFacing(player, player.side)
	local r = math.random(70)
	
	if obj ~= nil then
		if obj == 3204 and player.m == 10005 then
			weaving.cast(player)
			return
		end
	else
		anim(player)
		player:sendMinitext("You must stand in front of working table")
	end
end

}