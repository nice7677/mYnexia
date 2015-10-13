slow = {
on_learn = function(player) player.registry["learned_slow"] = 1 end,
on_forget = function(player) player.registry["learned_slow"] = 0 end,


cast = function(player, target)

	local magicCost = 1000
	local dura = 7000
	local aether = 30000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if target:hasDuration("slow") then
		player:sendAnimation(246)
		player:sendMinitext("Spell already cast!")
		return
	else
		if target.blType == BL_MOB then
			player:sendAction(6, 20)
			target:sendAnimation(12)
			target.speed = 200
			target:setDuration("slow", dura)
			player:sendMinitext("You cast Slow")
			player:playSound(94)
			player:setAether("slow", aether)
		
		elseif target.blType == BL_PC then
			if player:canPK(target) then
				if target:hasDuration("endure") then
					anim(player)
					player:sendMinitext("Target protected!")
					return
				else
					player:sendAction(6, 20)
					target:sendAnimation(12)
					target.speed = 200
					target:setDuration("slow", dura)
					player:sendMinitext("You cast Slow")
					player:playSound(94)
					target:sendMinitext(player.name.." reduced your movement speed!")
					player:setAether("slow", aether)
				end
			end
		end
		
		target:sendStatus()
		target:updateState()
	end
end,

while_cast_250 = function(player)

	player.speed = 200
	player:sendAnimation(12)
end,

uncast = function(player)

	player:calcStat()
	player:sendStatus()
	player:updateState()
	player:sendMinitext("Your move speed back to normal")
end,

requirements = function(player)
	
	local txt
	txt = "- 15 Rat Meat \n"
	txt = txt.."- 2 Dark Amber \n"
	txt = txt.."- 1 Turquoise Liquid \n"
	txt = txt.."- 1 Iron Sword \n"
	txt = txt.."- 1 Hunang Axe \n"
	txt = txt.."- 3000 Coins \n"
	
	local level = 85
	local item = {44, 18008, 31, 3003, 3025, 0}
	local amounts = {15, 2, 1, 1, 1, 3000}
	local desc = {"Slow down enemy move","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}