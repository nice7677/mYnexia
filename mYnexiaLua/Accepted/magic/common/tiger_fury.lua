tiger_fury = {
on_learn = function(player) player.registry["learned_tiger_fury"] = 1 end,
on_forget = function(player) player.registry["learned_tiger_fury"] = 0 end,

cast = function(player)

	local magicCost = 1000
	local dura = 240000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("tiger_fury") then anim(player) player:sendMinitext("Spell already cast!") return end
	if player:hasDuration("dragon_fury") or player:hasDuration("soul_fly") or player:hasDuration("serpent_fury") then
		anim(player)
		player:sendMinitext("Higher level of spell is already cast!")
	return else
		if not player:hasDuration("wolf_fury") then
			anim(player)
			player:sendMinitext("You must to cast Wolf's fury first!")
		return else
			player:flushDurationNoUncast(10001, 10001)
			player:setDuration("tiger_fury", dura)
			player.magic = player.magic - magicCost
			player:sendStatus()			
			player:sendAction(6, 20)
			player:playSound(31)
			player:sendAnimation(71)			
			player:sendMinitext("You cast Tiger fury")
		end
	end
end,

while_cast_250 = function(player) player.fury = 3 end,
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