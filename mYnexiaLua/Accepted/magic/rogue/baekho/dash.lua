dash = {

on_learn = function(player) player.registry["learned_dash"] = 1 end,
on_forget = function(player) player.registry["learned_dash"] = 0 end,
on_walk_while_cast = function(player) player:sendAnimationXY(15, player.x, player.y) end,

cast = function(player)

	local magicCost = 1000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end

	if player:hasDuration("dash") then
		player:sendAnimation(246)
		player:sendMinitext("Spell already cast!")
		return
	else
		player.magic = player.magic - magicCost
		player:setDuration("dash", 5000)
		player:setAether("dash", 15000)
		player.speed = 30
		player:sendMinitext("You cast Dash")
		player:sendAnimation(15)
		player:playSound(39)
		player:sendStatus()
	end
	
	player:sendAction(6, 20)
	
end,


while_cast_250 = function(player)

	player:sendAnimation(133)
	player.speed = 30
	player:sendStatus()
end,


uncast = function(player)
	
	if player.speed == 30 then player.speed = 80 end
	player:calcStat()
	
end
}