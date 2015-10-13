gm_entangle = {


cast = function(player, target)

	if target.ID == player.ID then return end
	if target.ID == 2 or target.ID == 18 then target:msg(4, "[INFO] "..player.name.." try to cast GM entangle on you", target.ID) return end
	
	if target:hasDuration("gm_entangle") then
		target:setDuration("gm_entangle", 0)
		
	return else
		target.registry["follow"] = player.ID
		target.sleep = 2
		target:sendAnimation(141)
		player:playSound(85)
		target:setDuration("gm_entangle", 60000)
		target:sendMinitext(player.name.." force you to follow him/her")
	end
end,

while_cast_125 = function(player)
	
	local caster = Player(player.registry["follow"])
	
	if caster ~= nil then
		if caster.side == 0 then
			player:warp(caster.m, caster.x, caster.y+1)
		elseif caster.side == 1 then
			player:warp(caster.m, caster.x-1, caster.y)
		elseif caster.side == 2 then
			player:warp(caster.m, caster.x, caster.y-1)
		elseif caster.side == 3 then
			player:warp(caster.m, caster.x+1, caster.y)
		end
		player.sleep = 2
		player:sendAnimation(141)
		player:playSound(84)
	else
		player:setDuration("gm_entangle", 0)
	end
end,

uncast = function(player)
	
	player.registry["follow"] = 0
	player:calcStat()
end
}
