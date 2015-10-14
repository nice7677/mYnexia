
spear_of_stealth = {

cast = function(player)

	if player.state == 0 then
		if player:hasDuration("spear_of_stealth") then return else
			player:sendAnimation(21)
			player:playSound(28)
			player.state = 2
			player:updateState()
			player:setDuration("spear_of_stealth", 15000)
		end
	end
end,

on_swing = function(player)

	local rate = math.random(100)
	
	if rate <= 15 then spear_of_stealth.cast(player) end
end,

while_cast = function(player)

	
end,

uncast = function(player)
	
	player:calcStat()
	if player.state == 2 then
		player.state = 0
		player:updateState()
	end
end
}