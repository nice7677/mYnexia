relief = {

cast = function(player)
	
	local magicCost = 30
	local heal = math.random(100, 200)
	
	if not player:canCast(1,1,0) then anim(player) return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast relief")
	player:sendAnimation(5)
	player:playSound(3)
	addHealth(player, heal)
	
	
end
}