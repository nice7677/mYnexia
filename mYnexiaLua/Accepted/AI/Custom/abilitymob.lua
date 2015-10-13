ore = {

on_spawn = function(mob)

	mob.side = math.random(0, 3)
	mob:move()
end
}

-----------------------------------------------------------------------------------------------

sheep = {

on_attacked = function(mob, attacker)

	mob.attacker = 0
	mob.target = 0
	sheep.move(mob, target)
end,

move = function(mob, target)

	c1 = math.random(0, 20)
	c2 = math.random(0, 10)
	if c1 > 3 then return else mob.side = c1 end
	mob:sendSide()
	if c1 < c2 then
		moved = mob:move()
	end
end
}

auto_sheep = {

on_spawn = function(mob)

	mob.attacker = 0
	mob.target = 0
	auto_sheep.move(mob, target)
end,

on_attacked = function(mob, attacker)
	
	mob.attacker = 0
	mob.target = 0
	auto_sheep.move(mob, target)
end,

move = function(mob, target)

	mob.side = math.random(0, 3)
	mob:sendSide()
end
}