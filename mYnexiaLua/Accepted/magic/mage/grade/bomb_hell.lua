bomb_hell = {
on_learn = function(player) player.registry["learned_bomb_hell"]=1 end,
on_forget = function(player) player.registry["learned_bomb_hell"]=0 end,

cast=function(player,target)

	local aether = 90000
	local dam = player.maxMagic*1.3 + math.random(50000, 100000)
	local pc = player:getObjectsInArea(BL_PC)
	local mob = player:getObjectsInArea(BL_MOB)
	local threat
	
	if not player:canCast(1,1,0) then return end
	
	player:setAether("bomb_hell", aether)
	player.magic = player.magic - player.magic
	player:sendStatus()
	player:sendAction(6, 30)
	player:playSound(500)
	player:playSound(107)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 10) then
				mob[i].attacker = player.ID
				mob[i]:sendAnimation(104)
				mob[i]:sendAnimationXY(352, mob[i].x, mob[i].y)
				threat = mob[i]:removeHealthExtend(dam, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(dam, 1,1,1,1,0)
			end
		end
	elseif #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 10) then
				if player:canPK(pc[i]) then
					if pc[i].state ~= 1 then
						pc[i].attacker = player.ID
						pc[i]:sendAnimation(104)
						pc[i]:sendAnimationXY(352, pc[i].x, pc[i].y)
						pc[i]:removeHealthExtend(dam, 1,1,1,1,0)
						pc[i]:sendMinitext(player.name.." attack you with Bomb Hell")
					end
				end
			end
		end
	end
					
	player:sendAnimation(134)
	player:playSound(99)
	player:playSound(73)
	player:sendMinitext("You cast Bomb Hell")
end     
}