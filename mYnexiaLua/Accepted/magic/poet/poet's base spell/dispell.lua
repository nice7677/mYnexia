dispell = {

cast = function(player, target)

	local magicCost = 5000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	local no = {"heal_charm", "harden_body", "shadow"}
	
	player:sendAction(6, 20)
	target:sendAnimation(10)
	player:playSound(99)

	if target.blType == BL_PC then
		if target.state ~= 1 then
			if target:hasDuration("heal_charm") or target:hasDuration("harden_body") or target:hasDuration("shadow") then return else
				target:flushDuration()
				target:sendMinitext(player.name.." cast Dispell on you")
				player:setAether("dispell", 30000)
			end
		else
			anim(player)
			player:sendMinitext("Target is already die!")
		end
	end
	player:sendMinitext("You cast Dispell")
end
}