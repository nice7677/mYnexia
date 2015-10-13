dragon_fury = {
on_learn = function(player) player.registry["learned_dragon_fury"] = 1 end,
on_forget = function(player) player.registry["learned_dragon_fury"] = 0 end,


cast = function(player)

	local magicCost = 1000
	local dura = 360000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if player:hasDuration("dragon_fury") then anim(player) player:sendMinitext("Spell already cast!") return end
	if player:hasDuration("soul_fly") or player:hasDuration("serpent_fury") then
		anim(player)
		player:sendMinitext("Higher level of spell is already cast!")
	return else
		if not player:hasDuration("tiger_fury") then
			anim(player)
			player:sendMinitext("You must to cast Tiger's fury first!")
		return else
			player:flushDurationNoUncast(10002, 10002)
			player:setDuration("dragon_fury", dura)
			player.magic = player.magic - magicCost
			player:sendStatus()			
			player:sendAction(6, 20)
			player:sendAnimation(72)
			player:playSound(59)
			player:playSound(507)
			player:sendMinitext("You cast Dragon's fury")
		end
	end
end,

while_cast_250 = function(player) player.fury = 4 end,
uncast = function(player) player:calcStat() end,

requirements = function(player)
	
	txt = "\n- 5 Snake Meat \n"
	txt = txt.."- 20 Silver Fox Fur \n"
	txt = txt.."- 1 Fox Tail"
	
	local level = 62
	local item = {49, 67, 68} -- snake_meat,  silver_fox_fur,  fox_tails
	local amounts = {5, 20, 1}
	local desc = {"Call the power of Dragon into your self, Swing Damage x 4", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}