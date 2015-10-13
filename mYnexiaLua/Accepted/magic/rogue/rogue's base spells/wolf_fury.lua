wolf_fury = {
on_learn = function(player) player.registry["learned_wolf_fury"] = 1 end,
on_forget = function(player) player.registry["learned_wolf_fury"] = 0 end,

cast = function(player)
	local duration = 120000
	local magicCost = 500

	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if not player:hasDuration("wolf_fury") and not player:hasDuration("tiger_fury") and not player:hasDuration("serpent_fury") and not player:hasDuration("soul_fly") then
		player:sendAction(6, 20)
		player:setDuration("wolf_fury", duration)
		player:sendAnimation(70, 0)
		player:playSound(9)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:calcStat()
		player:sendMinitext("You cast Wolf Fury")
	else
		anim(player)
		player:sendMinitext("Spell already cast!")
	end
end,

recast = function(player)
	player.enchant = player.enchant + 1
	player.dam = player.dam + 2
end,

uncast = function(player) player:calcStat() end,

requirements = function(player)
	
	local txt
	txt = "- 150 Chesnut \n"
	txt = txt.."- 30 Tiger Meat \n"
	txt = txt.."- 100 Coins \n"
	
	local level = 33
	local item = {43, 55, 0} 
	local amounts = {150, 30, 100}
	local desc = {"Swing Damage x 2", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}