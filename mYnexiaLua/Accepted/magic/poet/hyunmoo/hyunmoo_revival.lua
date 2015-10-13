hyunmoo_revival = {
cast = function(player)

	if not player:canCast(1,1,0) then return end
	if player.magic < 1000 then notEnoughMP(player) return end
	if player.state == 1 then player.state = 0 player:updateState() end
	
	player:sendAction(6, 20)
	player:sendAnimation(38)
	player:playSound(17)
	player.magic = player.maxMagic
	player.health = player.maxHealth
	player:sendStatus()
	player:sendMinitext("You cast Hyunmoo revival")
	player:setAether("hyunmoo_revival", 60000)
end
}