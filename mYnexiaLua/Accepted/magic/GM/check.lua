

check = {

cast = function(player, target)
	
	player:sendAction(6, 20)
	if target:hasDuration("check") then target:setDuration("check", 0) return else
		target:setDuration("check", 72000000)
	end
end,


while_cast = function(player)

	player:talk(2, "enchant: "..player.enchant..", fury: "..player.fury..", rage : "..player.rage)
end,

uncast = function(player)


end
}