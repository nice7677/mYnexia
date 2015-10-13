darken_fate = {
on_learn = function(player) player.registry["learned_darken_fate"]=1 end,
on_forget = function(player) player.registry["learned_darken_fate"]=0 end,


cast = function(player, target)
	
	local aether = 60000
	local magicCost = 5000
	local dura = 5000
	
	if not player:canCast(1,1,0) then return end	
	if player.magic < magicCost then notEnoughMP(player) return end

	if target.blType == BL_PC then
		if target.ID == 3 then player:sendAnimation(246) return end
		if target:hasDuration("darken_fate") then player:sendAnimation(246) player:sendMinitext("Spell already cast") return else
			if player:canPK(target) then
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You cast Darken Fate!")
				
				player:sendAction(6, 20)
				target:setDuration("darken_fate", dura)
				player:setAether("darken_fate", aether)
				target:sendAnimation(393)
				player:playSound(19)
				target:sendMinitext(player.name.." cast Darken Fate on you")
			end
		end
	end
end,


while_cast = function(player)

	player:sendAnimation(393)
	player.blind = 1
end,


uncast = function(player)

	player.blind = 0
	player:calcStat()
end
}