jujak_evocation = {

cast = function(player)

	if not player:canCast(1,1,0) then return end

	player.registry["cast_jujak_evo"] = 1
	player.registry["last_health"] = player.lastHealth
	player.maxHealth = player.health + player.health*.7
	player.health = player.maxHealth
	player:sendStatus()

	player:sendAction(6,20)
	player:sendAnimation(37)
	player:sendMinitext("You cast Jujak evocation")
end
}































