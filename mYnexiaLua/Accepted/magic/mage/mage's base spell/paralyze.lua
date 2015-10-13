paralyze = {
on_learn = function(player) player.registry["learned_paralyze"]= 1 end,
on_forget = function(player) player.registry["learned_paralyze"]= 0 end,


cast = function(player, target)
	
	local duration = 60000
	local magicCost = 20
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if (target.state == 1 or target.blType ~= BL_MOB) then player:sendMinitext("Invalid Target") return end
	if(target.paralyzed==true) or target:hasDuration("paralyze") then player:sendMinitext("Spell already cast") player:sendAnimation(246) return end	
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast paralyze")
	player:playSound(71)
	target:sendAnimation(144)
	target:setDuration("paralyze", duration)
	target.paralyzed = true
end,

while_cast = function(block)

	block.paralyzed = true
	
end,
	
uncast = function(mob) mob.paralyzed = false end,

requirements = function(player)

	txt = "- 70 Chesnut \n"
	txt = txt.. "- 1 God's food \n"
	txt = txt.. "- 10 Great Tiger Pelt \n"
	txt = txt.. "- 4000 Coins "
	
	local level = 60
	local items = {43, 7065, 70, 0}	--chesnut, god's food, great tiger pelt
	local amounts = {70, 1, 10, 4000}
	local desc = {"Make target(mobs only) stop for a while","To learn this spell you need to sacriface \n"..txt..""}
	return level, items, amounts, desc
end
}