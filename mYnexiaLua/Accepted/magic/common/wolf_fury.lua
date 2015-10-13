wolf_fury = {
on_learn = function(player) player.registry["learned_wolf_fury"] = 1 end,
on_forget = function(player) player.registry["learned_wolf_fury"] = 0 end,

cast = function(player)

	local magicCost = 500
	local dura = 120000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("wolf_fury") then anim(player) player:sendMinitext("Spell already cast!") return end
	if player:hasDuration("tiger_fury") or player:hasDuration("dragon_fury") or player:hasDuration("soul_fly") or player:hasDuration("serpent_fury") then
		anim(player)
		player:sendMinitext("Higher level of spell is already cast!")
	return else
		player:setDuration("wolf_fury", dura)
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAnimation(70)
		player:playSound(9)
		player:sendMinitext("You cast wolf's fury")
	end
end,

while_cast_250 = function(player) player.fury = 2 end,
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