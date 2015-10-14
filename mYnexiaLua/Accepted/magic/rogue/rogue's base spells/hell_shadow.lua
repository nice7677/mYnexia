

hell_shadow = {

on_swing_while_cast = function(player)

	player:playSound(340)
end,

on_death = function(mob)

	mob:sendAnimationXY(381, mob.x, mob.y)
end,

move = function(mob, target)
	
	local moved = true
	
	if mob.target ~= nil then
		moved = FindCoords(mob, target)
	return else
		if mob:hasDuration("die_timer") then
			dura = mob:getDuration("die_timer")
			mob:talk(2, "Dura : "..dura)
		end
	end
end,


cast = function(player)
	
	local magicCost = 10000
	
	if not player:canCast(1,1,0) then anim(player) return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAnimationXY(181, player.x, player.y)
	player:spawn(50000, player.x, player.y, 4)
	ninja = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
	if #ninja > 0 then
		for i = 1, #ninja do
			ninja[i]:setDuration("die_timer", 30000)
			hell_shadow.transform(player)
		end
		moveUp(ninja[1])
		moveDown(ninja[2])
		moveLeft(ninja[3])
		moveRight(ninja[4])
	end
	player:playSound(74)
	player:playSound(83)
	player:sendAnimationXY(373, player.x, player.y)	
	player:sendMinitext("You cast Hell Shadow")
end,

transform = function(player)

	player:setDuration("hell_shadow", 30000)
	player.disguise = 996
	player.disguiseColor = 0
	player.state = 4
	player:updateState()
end,

uncast = function(player)

	if player.state == 4 then
		player.state = 0
		player:updateState()
	end
end
}
	