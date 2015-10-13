slash = {
on_learned = function(player) player.registry["learned_slash"]=1 end,
on_forget = function(player) player.registry["learned_slash"]=0 end,

cast = function(player)

	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = player.health*.25
	local healthCost = player.health * .16
	local magicCost = 1000
	local m = player.m
	local x = player.x
	local y = player.y
	local threat
	
	if player.health < healthCost or player.health-healthCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough HP.")
		return
	end	
		player:sendAction(1, 20)
		player:talk(2, "Slash~!!")
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Slash.")
		player:playSound(14)
		
	if(player.side==0) then player:sendAnimationXY(31, player.x, player.y-1, 1) end
	if(player.side==1) then player:sendAnimationXY(31, player.x+1, player.y, 1) end
	if(player.side==2) then player:sendAnimationXY(31, player.x, player.y+1, 1) end
	if(player.side==3) then player:sendAnimationXY(31, player.x-1, player.y, 1) end
	
	if mobTarget ~= nil then
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		mobTarget:sendAnimation(31, 0)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif pcTarget ~= nil then
		pcTarget:sendAnimation(31, 0)
		
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end,

requirements = function(player)
	
	txt = "\n- 10 amber \n"
	txt = txt.."-1 steel sword \n"
	txt = txt.."- 5 great tiger pelt \n"

	local level = 55
	local item = {8012, 1004, 75}
	local amounts = {10, 1, 5}
	local desc = {"Deal damage 25% from Health.", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}