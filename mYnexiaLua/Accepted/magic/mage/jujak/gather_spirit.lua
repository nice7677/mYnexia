gather_spirit = {

on_learn = function(player) player.registry["learned_gather_spirit"] = 1 end,
on_forget = function(player) player.registry["learned_gather_spirit"] = 0 end,

cast = function(player)

	local aether = 90000
	local duration = 15000
	local magicCost = 1000
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if (player:hasDuration("gather_spirit")) then player:sendMinitext("Spell already cast") return end
	
	player:sendAction(6, 20)
	player:setAether("gather_spirit", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("gather_spirit", duration)
	player:playSound(94)
	player:sendAnimation(309, 0)
	player:sendMinitext("You cast Gather Spirit")
end,

while_cast = function(player)

	player:sendAnimation()
end
}