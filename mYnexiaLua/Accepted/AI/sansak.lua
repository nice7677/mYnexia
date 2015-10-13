sansak = {

cast = function(player, mob)

	player:spawn(10013, player.x, player.y, 1)
	mob = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
	if #mob > 0 then
		for i = 1, #mob do
			if mob[i].mobID == 10013 then
				mob[i]:setDuration("sansak", 60000, player.ID, 1)
			end
		end
	end
end,


while_cast = function(block, caster)

	
	
end,

uncast = function(block) block:removeHealth(block.health) end,
on_spawn = function(mob) mob:sendAnimation(16) end,
move = function(mob, target) end,
on_healed = function(mob) mob_ai_basic.on_healed(mob) end,
	
	
on_attacked = function(block, attacker)
	
	block:sendAnimation(331)
	block:playSound(353)
	block.attacker = 0
	block.target = 0
	block:talk(2, attacker.name.." : "..format_number(math.floor(attacker.damage)))
	attacker:msg(12, "[SANSAK]: You dealt "..format_number(math.floor(attacker.damage)).." damages on sansak", attacker.ID)
end
}
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				