reflect = {
on_learn = function(player) player.registry["learned_reflect"] = 1 end,
on_forget = function(player) player.registry["learned_reflect"] = 0 end,

cast = function(player, target)

	local duration = 10000
	local magicCost = 80
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) end
	if player:hasDuration("reflect") then anim(player) player:sendMinitext("Spell already cast!") return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Reflect.")
	player:playSound(92)
	player.registry["reflect"] = 1
	player:setDuration("reflect", 15000)
	player:sendAnimation(90, 0)
end,

while_cast = function(block)

	block.registry["reflect"] = 1
end,

uncast = function(block)
	
	block.registry["reflect"] = 0
	block:calcStat()
end,

being_hit = function(player, attacker)

	player:playSound(347)
	player:sendAnimation(425)
	player:sendHealth(0, 0)
	attacker.attacker = player.ID
	attacker:sendHealth(attacker.damage, attacker.critChance)
end,

requirements = function(player)

	txt = "- 70 Chesnut \n"
	txt = txt.."- 20 Silver fox fur \n"
	txt = txt.."- 2 Great tiger pelt \n"
	txt = txt.."- 500 Coins \n"

	local level = 27
	local item = {43, 67, 70, 0}
	local amounts = {70, 20, 2, 500}
	local desc = {"Reflecting damage to the attacker on self", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
