retribution = {

on_learn = function(player) player.registry["learned_retribution"] = 1 end,
on_forget = function(player) player.registry["learned_retribution"] = 0 end,

cast = function(player, target)

	local magicCost = player.magic*.5
	local damage = player.magic
	local threat
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if target.blType == BL_MOB then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendAction(6, 20)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
		target:sendAnimation(51)
		player:playSound(27)
		player:setAether("retribution", 60000)
		player:sendMinitext("You cast Retribution")
	elseif target.blType == BL_PC then
		player.magic = player.magic - magicCost
		player:sendStatus()	
		player:sendAction(6, 20)
		target.attacker = player.ID		
		target:removeHealthExtend(damage, 1,1,1,1,0)
		target:sendAnimation(51)
		player:playSound(27)
		player:setAether("retribution", 60000)
		target:sendMinitext(player.name.." attack you with Retribution!")
		player:sendMinitext("You cast Retribution")
	end
end,

requirements = function(player)

	txt = "- 1 Death Brain \n"
	txt = txt.."- 1 Lucky coins \n"
	txt = txt.."- 2000 Coins \n"
	
	local level = 60
	local item = {3072, 7047, 0}
	local amounts = {1, 1, 2000}
	local desc = {"Deals damage on 1 target damage based on current magic x 100% ", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
