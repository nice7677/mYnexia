desperate_attack = {
on_learned = function(player) player.registry["learned_desperate_attack"]=1 end,
on_forget = function(player) player.registry["learned_desperate_attack"]=0 end,


cast = function(player)

	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local aether = 1000
	local damage = ((player.health *.35) + (player.magic *.35))
	local threat
	local healthCost = player.health*.25
	local magicCost = 1000
	local minHealth = 100
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if(player.side==0) then player:sendAnimationXY(287, player.x, player.y-1, 1) end
	if(player.side==1) then player:sendAnimationXY(287, player.x+1, player.y, 1) end
	if(player.side==2) then player:sendAnimationXY(287, player.x, player.y+1, 1) end
	if(player.side==3) then player:sendAnimationXY(287, player.x-1, player.y, 1) end

	player:sendAction(1, 20)
	player:setAether("desperate_attack", aether)
	player:sendMinitext("You cast Desperate Attack.")
	player:talk(2, "Desperate Attack~!!!")
	player:playSound(35)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
		
	if (mobTarget ~= nil) then
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		mobTarget:sendAnimation(287)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (pcTarget ~= nil) then
		if pcTarget.state ~= 1 then
			if (player:canPK(pcTarget)) then
				pcTarget:sendAnimation(287, 0)
				pcTarget.attacker = player.ID
				pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcTarget:sendMinitext(player.name.." attack you with Desperate attack!")
			end
		end
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 200 Chesnut \n"
	txt = txt.."- 1 Iron Saber \n" 
	txt = txt.."- 10 Great Tiger Pelt \n"
	txt = txt.."- 1000 Coins \n"

	local level = 50
	local item = {43, 3034, 70, 0}
	local amounts = {200, 1, 10, 1000}
	local desc = {"Brute Force to target", "To learn this spell you must to sacriface:\n"..txt..""}
	return level, item, amounts, desc
end
}