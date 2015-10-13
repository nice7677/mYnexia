doze = {
on_learn = function(player) player.registry["learned_doze"]=1 end,
on_forget = function(player) player.registry["learned_doze"]=0 end,

cast = function(player, target)

	local mob = target:getObjectsInArea(BL_MOB)
	local pc = target:getObjectsInArea(BL_PC)
	local aether = 60000
	local duration = 20000
	local magicCost = 250
	local dist = 1
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if target:hasDuration("doze") then player:sendMinitext("Spell already cast") player:sendAnimation(246) return end
	
	player:sendAction(6, 20)
	player:setAether("doze", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Doze")
	
	if target ~= nil then
		if target.blType == BL_MOB then
			target.attacker = player.ID
			target:sendAnimation(33)
			target:setDuration("doze", duration)
		elseif target.blType == BL_PC then
			if player:canPK(target) then
				target.attacker = player.ID
				target:sendAnimation(33)
				target:setDuration("doze", duration)
				target:sendMinitext(player.name.." cast Doze on you")
			end
		end
		
		if #mob > 0 then
			for i = 1, #mob do
				if distanceSquare(target, mob[i], dist) then
					if mob[i]:hasDuration("doze") then return else
						mob[i].attacker = player.ID
						mob[i]:setDuration("doze", duration)
						mob[i]:sendAnimation(33)
					end
				end
			end
		elseif #pc > 0 then
			for i = 1, #pc do
				if distanceSquare(player, pc[i], dist) then
					if player:canPK(pc[i]) then
						if pc[i]:hasDuration("doze") then return else
							pc[i].attacker = player.ID
							pc[i]:sendAnimation(33)
							pc[i]:setDuration("doze", duration)
							pc[i]:sendMinitext(player.name.." cast Doze on you")
						end
					end
				end
			end
		end
	end
end,

while_cast = function(block)
	
	block.sleep = 2
	block:sendAnimation(33, 0)

end,


uncast = function(block)
	if (block.blType == BL_MOB) then
		if (block.sleep - .3 < 1) then
			block.sleep = 1
		else
			block.sleep = block.sleep - .3
		end
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	
	txt = "- 1 Turquoise Liquid \n"
	txt = txt.. "- 5 Dark Amber \n"
	txt = txt.. "- 1 Hunang Axe \n"
	txt = txt.. "- 1000 Coins \n"
	
	local level = 80
	local item = {31, 18008, 3025, 0} -- turquoise liquid, dark amber, hunang axe
	local amounts = {1, 5, 1, 1000}
	local desc = {"Lock target and target's around", "To learn this spell you must to sacriface:\n"..txt..""}
	
	return level, item, amounts, desc
end
}