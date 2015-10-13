barrier = {
on_learn = function(player) player.registry["learned_barrier"] = 1 end,
on_forget = function(player) player.registry["learned_barrier"] = 0 end,

cast = function(player, target)

	local duration = 240000
	local magicCost = 80
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) end
	if player:hasDuration("barrier") then anim(player) player:sendMinitext("Spell already cast!") return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Barrier.")
	player:playSound(92)
	player:setDuration("barrier", duration, 0, 1)
	player:sendAnimation(297, 0)
	
end,

recast = function(player) player.deduction = player.deduction - .45 end,
uncast = function(block) block:calcStat() end,

requirements = function(player)

	txt = "- 70 Chesnut \n"
	txt = txt.."- 20 Silver fox fur \n"
	txt = txt.."- 2 Great tiger pelt \n"
	txt = txt.."- 500 Coins \n"

	local level = 27
	local item = {43, 67, 70, 0}
	local amounts = {70, 20, 2, 500}
	local desc = {"Reduces damage by a great amount on self", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}