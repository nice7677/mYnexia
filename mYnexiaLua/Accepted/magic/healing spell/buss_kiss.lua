buss_kiss = {

on_learn = function(player) player.registry["learned_buss_kiss"] = 1 end,
on_forget = function(player) player.registry["learned_buss_kiss"] = 0 end,

cast = function(player, target)

	local heal = player.magic*1.25
	local magicCost = player.magic*.5
	
	if not player:canCast(1,1,0) then return end
	if target.blType ~= BL_PC then anim(player) player:sendMinitext("Invalid Target!") return end
	if target.state == 1 then anim(player) player:sendMinitext("Target already die!") return end

	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Buss kiss")
	player:setAether("buss_kiss", 30000)
	player:sendMinitext("You cast Buss Kiss")
	
	target:sendAnimation(64)
	player:playSound(12)
	addHealth(target, heal)
	target:sendMinitext(player.name.." cast Buss Kiss on you")
end
}