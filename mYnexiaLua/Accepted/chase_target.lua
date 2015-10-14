

chase_target2 = {

cast = function(player, target)
	
	player:sendAction(6, 20)
	if target ~= nil then
		target.registry["chase_target2"] = player.ID
		if target:hasDuration("chase_target2") then
			target:setDuration("chase_target2", 0)
		return else
			target:setDuration("chase_target2", 5000)
		end
	end
end,


while_cast = function(player)
	
	local moved = true
	local target = Player(player.registry["chase_target2"])
	local dura = player:getDuration("chase_target2")
	
	if target ~= nil then
		player:talk(0, "Ku kejar kau dalam ".. dura/1000 .." detik!")
		moved = FindCoords(player, target)
	end
end,

uncast = function(player)
	
	player.registry["chase_target2"] = 0
	player:talk(0, player.name..": cape pak..")
	
end
}