		
cho_spirit = {

on_learn = function(player) player.registry["learn_cho_spirit"] = 1 end,
on_forget = function(player) player.registry["learn_cho_spirit"] = 0 end,

cast = function(player)

	local magicCost = 1000

	if not player:canCast(1,1,0) then return end
	
	player:sendAction(6, 20)
	player:sendMinitext("You cast Cho Spirit")	
		
	if player:hasDuration("cho_spirit") then
		player:setDuration("cho_spirit", 0)
		return
	else
		player:setDuration("cho_spirit", 30000)
	end
end,


while_cast = function(player)

	local pc = player:getObjectsInArea(BL_PC)
	local mob = player:getObjectsInArea(BL_MOB)
	local threat 
	local healthCost = player.health*.03
	local minHealth = 10000
	local damage = player.health*.2
	local x = player.x
	local y = player.y
	local m = player.m
	
	if player.health < healthCost or player.health - healthCost < minHealth then player:setDuration("cho_spirit", 0) return end
	
	player.health = player.health - healthCost
	player:sendStatus()

	player:sendAnimationXY(255, x-1, y)
	player:sendAnimationXY(255, x+1, y)
	player:sendAnimationXY(255, x, y-1)
	player:sendAnimationXY(255, x, y+1)
	
	if #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 3) then
				if pc[i].state ~= 1 and player:canPK(pc[i]) then
					if pc[i].ID ~= player.ID then
						pc[i].attacker = player.ID
						pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
						pc[i]:sendAnimation(306)
					end
				end
			end
		end
	end
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 3) then
				mob[i].attacker = player.ID
				threat = mob[i]:removeHealthExtend(damage, 1,1,1,1,2)
				player:addThreat(mob[i].ID, threat)
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
				mob[i]:sendAnimation(306)
			end
		end
	end
end,

uncast = function(player) player:calcStat() end
}










