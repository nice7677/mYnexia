kakek_market = {

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

cast = function(player)

	local mob = getTargetFacing(player, BL_MOB)
	player:sendAction(29, 20)
	if mob ~= nil then
		if mob.yname == "kakek_market" then
			mob:warp(mob.m, mob.x-1, mob.y)
			mob:sendAnimation(137)
			player:playSound(84)
			mob:sendAnimation(142)
			mob:talk(0, "Kakek : Toloooooong! awas kauuuu "..player.name.."!!")
			mob:setDuration("kakek_market", 3000)
			player:giveXP(500)
		end
	end
end,

while_cast_250 = function(mob)

	mob:sendAnimation(142)
end,

uncast = function(mob)

	mob:sendAnimationXY(223, mob.x, mob.y)
	mob:playSound(84)
	for i = 1, 2 do mob:playSound(73) end	
	mob:removeHealth(mob.health)
end
}

