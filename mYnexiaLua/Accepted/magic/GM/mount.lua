mount = {
cast = function(player, target)

	if target.blType == BL_PC then
		if target.state ~= 1 then
			target.state = 3
			target:updateState()
		end
	end
end
}