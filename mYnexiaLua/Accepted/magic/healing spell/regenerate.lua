regenerate = {
on_learn = function(player) player.registry["learned_regenerate"] = 1 end,
on_forget = function(player) player.registry["learned_regenerate"] = 0 end,

cast = function(player, target)

	local heal = player.magic*.002 + 500
	local magicCost = 700
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if (target.state == 1) then player:sendAnimation(246) player:sendMinitext("Target already die") return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	

	player:sendAction(6, 20)
	player:playSound(23)
	target:sendAnimation(57)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Regenerate.")
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Regenerate on you.")
end
}