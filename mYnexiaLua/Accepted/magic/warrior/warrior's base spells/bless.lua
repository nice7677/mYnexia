bless = {
on_learn = function(player) player.registry["learned_bless"] = 1 end,
on_forget = function(player) player.registry["learned_bless"] = 0 end,

cast = function(player)

	local duration = 160000
	local magicCost = 1000
	
	if player.state == 2 then player.state = 0 player:updateState() return end
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if player:hasDuration("bless") then
		player:sendAnimation(246, 0)
		player:sendMinitext("Spell already cast")
	else
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(58, 0)
		player:playSound(6)
		player:sendMinitext("You cast Bless")
		player:setDuration("bless", duration)
	end
end,

recast = function(player)	

	player.grace = player.grace*2
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)

	txt = "\n- 80 Chesnut \n"
	txt = txt.."\n- 5 Hartshorn"
	
	local level = 18
	local items = {43, 63} -- chesnut, hartshorn
	local itemAmounts = {80, 5}
	local description = {"Increase your grace", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}