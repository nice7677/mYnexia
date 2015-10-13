tiger_slash = {
on_learned = function(player) player.registry["learned_tiger_slash"]=1 end,
on_forget = function(player) player.registry["learned_tiger_slash"]=0 end,

cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local aether = 0
	local damage = math.random(player.health*1.8, player.health*2)
	local threat
	local healthCost = player.health*.5
	local magicCost = 1000
	local minHealth = 100
	
	if player.state == 2 then player.state = 0 player:updateState() return end
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if(player.side==0) then player:sendAnimationXY(67, player.x, player.y-1, 1) end
	if(player.side==1) then player:sendAnimationXY(67, player.x+1, player.y, 1) end
	if(player.side==2) then player:sendAnimationXY(67, player.x, player.y+1, 1) end
	if(player.side==3) then player:sendAnimationXY(67, player.x-1, player.y, 1) end

	player:sendAction(1, 20)
	player:setAether("tiger_slash", aether)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Tiger Slash")
	player:talk(2, "Tiger Slash~!!")
	player:playSound(87)
		
	if (mobTarget ~= nil) then
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		mobTarget:sendAnimation(67, 0)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (pcTarget ~= nil) then
		pcTarget:sendAnimation(67, 0)
		
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:sendMinitext(player.name.." hit you with Tiger Slash!")
		end
	end
end
}