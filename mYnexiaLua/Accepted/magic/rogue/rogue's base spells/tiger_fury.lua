tiger_fury = {
on_learn = function(player) player.registry["learned_tiger_fury"] = 1 end,
on_forget = function(player) player.registry["learned_tiger_fury"] = 0 end,

cast = function(player)
	local duration = 180000
	local magicCost = 1000

	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	
	if (player:hasDuration("tiger_fury")) then
		player:sendAnimation(246)
		player:sendMinitext("Spell already cast!")
	
	elseif player:hasDuration("serpent_fury") or player:hasDuration("dragon_fury") or player:hasDuration("soul_fly") then
		anim(player)
		player:sendMinitext("Higher version of spell is running")
		
	elseif (player:hasDuration("wolf_fury")) then
		player:sendAction(6, 20)
		player:setDuration("wolf_fury", 0)
		player:setDuration("tiger_fury", duration)
		player:playSound(110)
		player:playSound(9)
		player:sendAnimation(71)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:calcStat()
		player:sendMinitext("You cast Tiger Fury")
	else
		player:sendAnimation(246, 0)
		player:sendMinitext("You must to cast Wolf fury first!")
	end
end,

recast = function(player)
	player.enchant = player.enchant + 2
	player.dam = player.dam + 4
end,

uncast = function(player) player:calcStat() end,

requirements = function(player)
	
	local txt
	txt = "- 100 Chesnut \n"
	txt = txt.."- 1 Moon blade \n"
	txt = txt.."- 1 War hat \n"

	local level = 56
	local item = {43, 3024, 6015}
	local amounts = {100, 1, 1}
	local desc = {"swingDamage x3", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}