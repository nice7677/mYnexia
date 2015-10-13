body_replacement = {

on_learn = function(player) player.registry["learned_body_replacement"] = 1 end,
on_forget = function(player) player.registry["learned_body_replacement"] = 0 end,

cast = function(player)
	
	if not player:canCast(1,1,0) then return end
	if player.magic < 5000 then notEnoughMP(player) return end

	if player:hasDuration("body_replacement") then
		player:sendAnimation(246)
		player:sendMinitext("Spell already cast")
	else
		player:setDuration("body_replacement", 15000)
		player:setAether("body_replacement", 7000)
		player:sendMinitext("You cast Body Replacement")
	end
end,

being_hit = function(player)

	player:setDuration("body_replacement", 0)
	player:sendAnimationXY(292, player.x, player.y)
	player:playSound(73)
	pushBack(player)
	player:sendHealth(0, 0)
end
}