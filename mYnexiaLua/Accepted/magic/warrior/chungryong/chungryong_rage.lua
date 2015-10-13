chungryong_rage = {
cast = function(player)

	if player:hasDuration("cr1") then
		cr2.cast(player)
	elseif player:hasDuration("cr2") then
		cr3.cast(player)
	elseif player:hasDuration("cr3") then
		cr4.cast(player)
	elseif player:hasDuration("cr4") then
		cr5.cast(player)
	elseif player:hasDuration("cr5") then
		player:sendAnimation(246)
		player:sendMinitext("You already reach the highest Rage")
	else
		cr1.cast(player)
	end
end,

requirements = function(player)

	txt = "\n- 1 Chungryong Symbol \n"
	txt = txt.."- 1 Spiky Bat \n"
	txt = txt.."- 2 Titanium Glove \n"
	txt = txt.."- 10 Golden Chesnut \n"
	txt = txt.."- 50000 Coins"

	local level = 91
	local item = {18002, 3007, 7038, 76, 0} 
	local amounts = {1, 1, 2, 10, 50000}
	local desc = {"Call the power of Mythic Chungryong into your soul", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}







-------------[[ Chungryong Rage 1 ]]-------------

cr1 = {
cast = function(player)
	if not player:hasDuration("cr1") then
		player:sendAction(18,20)
		player:sendAnimation(36)
		player:setDuration("cr1", 60000)
		player:talk(2, "Chungryong Rage 1")
	end
end,

while_cast = function(player) player.rage = player.rage + .001 end,
uncast = function(player) player:calcStat() end
}

-------------[[ Chungryong Rage 2 ]]-------------

cr2 = {
cast = function(player)
	if player:hasDuration("cr1") then
		player:sendAction(18,20)
		player:sendAnimation(36)
		player:setDuration("cr1", 0)
		player:setDuration("cr2", 120000)
		player:talk(2, "Chungryong Rage 2")
	end
end,
	
while_cast = function(player) player.rage = player.rage + .002 end,
uncast = function(player) player:calcStat() end	
}

-------------[[ Chungryong Rage 3 ]]-------------

cr3 = {
cast = function(player)
	if player:hasDuration("cr2") then
		player:sendAction(18,20)
		player:sendAnimation(36)
		player:setDuration("cr2", 0)
		player:setDuration("cr3", 240000)
		player:talk(2, "Chungryong Rage 3")
	end
end,
	
while_cast = function(player) player.rage = player.rage + 0.003 end,
uncast = function(player) player:calcStat() end
}

-------------[[ Chungryong Rage 4 ]]-------------

cr4 = {
cast = function(player)
	if player:hasDuration("cr3") then
		player:sendAction(18,20)
		player:sendAnimation(36)
		player:setDuration("cr3", 0)
		player:setDuration("cr4", 360000)
		player:talk(2, "Chungryong Rage 4")
	end
end,
	
while_cast = function(player) player.rage = player.rage + 0.004 end,
uncast = function(player) player:calcStat() end
}

-------------[[ Chungryong Rage 5 ]]-------------

cr5 = {
cast = function(player)
	if player:hasDuration("cr4") then
		player:sendAction(18,20)
		player:sendAnimation(36)
		player:setDuration("cr4", 0)
		player:setDuration("cr5", 360000)
		player:talk(2, "Chungryong Rage 5")
	end
end,
	
while_cast = function(player) player.rage = player.rage + 0.005 end,
uncast = function(player) player:calcStat() end


}		
	