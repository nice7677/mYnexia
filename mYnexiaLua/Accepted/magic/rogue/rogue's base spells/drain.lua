drain = {

on_learn = function(player) player.registry["learned_drain"] = 1 end,
on_forget = function(player) player.registry["learned_drain"] = 0 end,

cast = function(player, target)

	local magicCost = 200
	local heal = math.random(1000,2000)
	local anim = 44
	local sound = 5
	local threat
	
	if target.ID == player.ID then return end
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	if target.blType == BL_MOB then
		player:sendAction(6, 20)
		target.attacker = player.ID
		target:sendAnimation(anim)
		player:playSound(sound)
		threat = target:removeHealthExtend(heal, 1,1,1,1,2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(heal, 1,1,1,1,0)
		player:addHealth(heal)
		player:sendMinitext("You cast Drain")
		
	elseif target.blType == BL_PC then
		if player:canPK(target) then
			player:sendAction(6, 20)
			target.attacker = player.ID
			target:sendAnimation(anim)
			player:playSound(sound)
			target:removeHealthExtend(heal, 1,1,1,1,0)
			player:addHealth(heal)
			player:sendMinitext("You cast Drain")
			target:sendMinitext(player.name.." cast Drain on you!")
		end
	end
end,

requirements = function(player)
	
	local txt
	txt = "- 190 Chesnut \n"
	txt = txt.."- 10 Dark Amber \n"
	txt = txt.."- 5000 Coins \n"

	local level = 80
	local item = {43, 18008, 0}
	local amounts = {190, 10, 5000}
	local desc = {"Drain your target health","To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				