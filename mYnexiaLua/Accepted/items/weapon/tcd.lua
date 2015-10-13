tcd = {

on_swing = function(player)
	
	if not player:canCast(1,1,0) then return end
	
	if not player:hasDuration("tcd") and not player:hasAether("tcd") then
		tcd.cast(player)
	elseif player:hasAether("tcd") then
		if player:hasDuration("tcd") then return else
			get = player:getAether("tcd")
			player:sendMinitext("Weapon cooldown : "..countDownSeconds(get).." sec")
		end
	end
end,

cast = function(player)

	player:sendAnimation(323)
	player:playSound(111)
	player:setDuration("tcd", 15000)
	player:setAether("tcd", 25000)	
end,

uncast = function(player)

	player:calcStat()
end,

being_hit = function(player)
	
	player:setDuration("tcd", 0)
	player:sendAction(3,60)
	player:playSound(347)
	player:playSound(365)
	player:sendAnimation(325)
	player:sendAnimation(424)
	player:sendHealth(0, 0)
end
}

