endure = {

on_learn = function(player) player.registry["learned_endure"] = 1 end,
on_forget = function(player) player.registry["learned_endure"] = 0 end,
while_cast = function(player) player.registry["has_cast_endure"] = 1 end,
uncast = function(player) player.registry["has_cast_endure"] = 0 end,

cast = function(player)

	local magicCost = 1000
	local anim = 171
	local sound = 21
	local dura = 120000

	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player:hasDuration("endure") or player.registry["has_cast_endure"] > 0 then
		anim(player)
		player:sendMinitext("Spell already cast!")
		return
	else
		player:sendAction(6, 20)
		player.registry["has_cast_endure"] = 1
		player:setDuration("endure", dura)
		player:sendAnimation(anim)
		player:playSound(sound)
		player:sendMinitext("You cast Endure")
		player.magic = player.magic - magicCost
		player:sendStatus()
	end
	
end
}