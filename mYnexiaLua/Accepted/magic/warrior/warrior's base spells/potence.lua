potence = {
on_learn = function(player) player.registry["learned_potence"] = 1 end,
on_forget = function(player) player.registry["learned_potence"] = 0 end,

cast = function(player)
	local duration = 120000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if player:hasDuration("potence") then
		player:sendAnimation(246)
		player:sendMinitext("Spell already Cast")
	else
		player:sendAction(6, 20)
		player:setDuration("potence", duration)
		player:sendAnimation(2, 0)
		player:playSound(6)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Potence.")
	end
end,

recast = function(player)
	player.enchant = player.enchant + 1
	player.dam = player.dam + 1
	player.grace = player.grace +4
end,

uncast = function(player) player:calcStat() end,

requirements=function(player)

	txt = "\n- 80 Chesnut \n"
	txt = txt.."- 1 War Hat \n"
	txt = txt.."- 2 Great Tiger Pelt"

	local level = 50
	local item = {43, 6015, 70} --chesnut, war_hat, great tiger pelt
	local amounts = {80, 1, 2}
	local desc = {"Increase Damage" , "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}