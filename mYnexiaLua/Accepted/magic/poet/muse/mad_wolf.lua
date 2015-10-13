mad_wolf = {

cast = function(player, target)
	
	if target ~= nil then
		player:spawn(1003, player.x, player.y, 1)
		mob = player:getObjectsInCell(player.m, player.x, player.y, 1)
		if #mob > 0 then
			for i = 1, #mob do
				mob[i].owner = player.ID
				mob[i].summon = true
				mob[i].target = target.ID
				mob[i]:setDuration("mad_wolf", 20000)
			end
		end
	end
end,

uncast = function(block) block:removeHealth(block.health) end,
move = function(mob, target) mob_ai_basic.move(mob, target) end,

on_attacked = function(mob)
	
	mob.attacker = 0
	mob.target = 0
end,

attack = function(mob,target)
	local moved
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	
	if (target) then
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then target = block end
		moved = FindCoords(mob,target)
		if(moved and mob.target ~= mob.owner) then
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end

}