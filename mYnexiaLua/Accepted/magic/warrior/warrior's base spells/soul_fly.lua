soul_fly = {
on_learn = function(player) player.registry["learned_soul_fly"] = 1 end,
on_forget = function(player) player.registry["learned_soul_fly"] = 0 end,

cast = function(player)

	local magicCost = 1000
	local dura = 420000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("soul_fly") then anim(player) player:sendMinitext("Spell already cast!") return end

	if not player:hasDuration("dragon_fury") then
		anim(player)
		player:sendMinitext("You must to cast Dragon's fury first!")
	return else
		player:flushDurationNoUncast(10003, 10003)
		player:setDuration("soul_fly", dura)
		player.magic = player.magic - magicCost
		player:sendStatus()			
		player:sendAction(6, 20)
		player:playSound(9)
		player:playSound(95)
		player:playSound(110)
		player:sendAnimation(61)
		player:sendMinitext("You cast Soul fly")
	end
end,

while_cast_250 = function(player) player.fury = 5 end,
uncast = function(player) player:calcStat() end,

requirements = function(player)

	txt = "\n- 100 Chesnut \n"
	txt = txt.."- 3 Hunang Axe \n"
	txt = txt.."- 3500 Coins"

	local level = 80
	local item = {43, 3025, 5}
	local amounts = {100, 3, 3500}
	local desc = {"Swing Damage x 5", "To learn this spell you must to sacriface "..txt..""}
	return level, items, amounts, desc
end
}