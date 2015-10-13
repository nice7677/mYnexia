berserk = {
on_learned = function(player) player.registry["learned_berserk"]=1 end,
on_forget = function(player) player.registry["learned_berserk"]=0 end,

cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = player.health*.40 +15000
	local healthCost = player.health * .35
	local magicCost = 1000
	local m = player.m
	local x = player.x
	local y = player.y
	local threat
	
	if player.health < healthCost or player.health-healthCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not enough HP")
		return
	end	
		player:sendAction(1, 20)
		player:talk(2, "Berserk~!!")
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Berserk")
		player:playSound(14)
		
	if(player.side==0) then player:sendAnimationXY(6, player.x, player.y-1, 1) end
	if(player.side==1) then player:sendAnimationXY(6, player.x+1, player.y, 1) end
	if(player.side==2) then player:sendAnimationXY(6, player.x, player.y+1, 1) end
	if(player.side==3) then player:sendAnimationXY(6, player.x-1, player.y, 1) end
	
	if mobTarget ~= nil then
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		mobTarget:sendAnimation(301, 0)
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif pcTarget ~= nil then
		pcTarget:sendAnimation(301, 0)
		
		if (player:canPK(pcTarget)) then
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end,

requirements = function(player)

	txt = "\n- 100 Chesnut \n"
	txt = txt.."- 20 Amber \n"
	txt = txt.."- 2 Maxcaliber \n"
	txt = txt.."- 5000 Coins"

	local level = 72
	local item = {43, 18012, 3026, 0}
	local amounts = {100, 20, 2, 5000}
	local desc = {"Damage 40% from vitality + 15k++.", "To learn this spell you must to sacriface "..txt..""}
	return level, item, amounts, desc
end
}