shadow = {

on_learn = function(player) player.registry["learned_shadow"] = 1 end,
on_forget = function(player) player.registry["learned_shadow"] = 0 end,

cast = function(player)

	local magicCost = 10000

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if player.state == 2 then player:sendAnimation(246) player:sendMinitext("Can't do that!") return end
	
	if player:hasDuration("shadow") then
		player:sendMinitext("Spell already cast")
		player:sendAnimation(246)
		return
	else
		if target.state == 1 then
			player:sendMinitext("Target already die!")
			return
		end
		player:sendAction(6, 20)
		player:sendAnimation(103)
		player:sendAnimation(286)
		player:playSound(83)
		player.state = 2
		player:updateState()
		player:sendMinitext("You cast Shadow!")
		player:setDuration("shadow", 5000)
		player.magic = player.magic - magicCost
		player:sendStatus()
		if player.ID ~= 2 then player:setAether("shadow", 30000) end
	end
end,
	
while_cast = function(player)
	
	player:sendAnimation(284)
	player.state = 2
end,


while_cast_250 = function(player)

	
end,

uncast = function(player)

	if player.state == 2 then
		player.state = 0
		player:updateState()
	end
	player:calcStat()
end

}
