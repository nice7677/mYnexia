rejuvenate = {

on_learn = function(player) player.registry["learned_rejuvenate"] = 1 end,
on_forget = function(player) player.registry["learned_rejuvenate"] = 0 end,

cast = function(player, target)

	local magicCost = 1000
	local anim = 66
	local sound = 23
	local heal = math.abs(math.random(1000, 2000))
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Rejuvenate")
	player:playSound(sound)

	addHealth(target, heal)
	target:sendAnimation(anim)
	target:sendMinitext(player.name.." heal you with Rejuvenate")
end
}
		