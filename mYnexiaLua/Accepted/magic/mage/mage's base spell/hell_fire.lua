hell_fire = {

on_learn = function(player) player.registry["learned_hell_fire"] = 1 end,
on_forget = function(player) player.registry["learned_hell_fire"] = 0 end,

cast = function(player, target)

	local aether = 9000
	local damage = player.magic*1.8 + player.wisdom
	local threat
	local magicCost = player.magic
	
	if player.state == 2 then player.state = 0 player:updateState() return end
	if (not player:canCast(1, 1, 0)) then return end
	
	player:sendAction(6, 20)
	player:playSound(73)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Hell Fire")
	player:setAether("hell_fire", aether)
	
	if (target.blType == BL_MOB) then
		target:sendAnimationXY(112, target.x, target.y)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1,1,1,1,0)
	elseif (target.blType == BL_PC and player:canPK(target)) then
		target:sendAnimationXY(112, target.x, target.y)
		target:sendMinitext(player.name.. " attack you with Hell Fire")
		target.attacker = player.ID
		target:removeHealthExtend(damage,1,1,1,1,0)
	end
end,

requirements = function(player)

	txt = "\n- 10 Star Point \n" 
	txt = txt.."- 10 Dark Amber \n"
	txt = txt.."- 1 Star Staff \n"
	txt = txt.."- 9000 coins"

	local level = 99
	local item = {18013, 18008, 3070, 0}		-- star point, dark amber, star staff
	local amounts = {10, 10, 1, 9000}
	local desc = {"A powerfull fire from hell that burn one target , damage based on Mana.", "To learn this spell you need to sacriface "..txt..""}
	return level, item, amounts, desc
end
}

burn = {
while_cast = function(player, caster)
	
	local damage = math.random(100000, 150000)
	
	player:sendAnimation(45)
	player:removeHealthExtend(damage,1,1,1,1,0)
end
}










