teleport = {
on_learn = function(player) player.registry["learned_teleport"]=1 end,
on_forget = function(player) player.registry["learned_teleport"]=0 end,

cast = function(player, target)

	local targets = {target.blType == BL_MOB , target.blType == BL_PC}
	local magicCost = 5000
	local aether = 15000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAnimationXY(246, player.m, player.x, player.y)
	player:playSound(725)
		
	if target ~= nil then
		player:sendAction(6, 20)
		player:warp(player.m, target.x, target.y)
		player:setAether("teleport", aether)
		player.magic = player.magic - magicCost
		player:sendMinitext("You cast Teleport")
		player:sendStatus()
		target:sendAnimation(177,0)
		target.attacker = player.ID
		target:sendMinitext(player.name.." cast Teleport on you")
		player:sendAction(6, 20)
	else
		player:sendMinitext("Invalid Target")
		player:sendAnimation(246)
	end
end
}