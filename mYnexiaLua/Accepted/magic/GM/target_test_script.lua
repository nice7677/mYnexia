target_test_script = {


cast = function(player, target)

	if target.blType == BL_PC then
		if target:hasDuration("target_test_script") then
			target:setDuration("target_test_script", 0)
			return
		else
			target:setDuration("target_test_script", 60000)
		end
	end
	
end,



while_cast = function(player)

	local dura = player:getDuration("target_test_script")
	
	sec = string.format("%02.f", math.floor(totalSeconds - hours * 3600 - minutes * 60))
	
	player:talk(0, sec)
end
}