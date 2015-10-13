harden_body = {

on_learn = function(player) player.registry["learned_harden_body"] = 1 end,
on_forget = function(player) player.registry["learned_harden_body"] = 0 end,


cast = function(player)

	local rate = math.random(100)
	local magicCost = 500
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if player:hasDuration("harden_body") then
		anim(player)
		player:sendMinitext("Spell already cast!")
		return
	else
		if rate >= 70 then
			player:sendAction(6, 20)
			player:sendAnimation(11)
			player:playSound(173)
			player:setDuration("harden_body", 10000)
			player:sendMinitext("You cast Harden Body")
		else
			player:sendMinitext("Harden Body Failed!")
			return
		end
	end
end,

while_cast = function(player,attacker)
	
	if attacker ~= nil then
		attacker.damage = 0
		player.attacker = 0
	end

end,

uncast = function(player)
	player:calcStat()
end
}