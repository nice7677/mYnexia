set_trap = {
on_learn = function(player) player.registry["learned_set_trap"] = 1 end,
on_forget = function(player) player.registry["learned_set_trap"] = 0 end,

cast = function(player)

	local aether = 10000
	local magicCost = 250
	
	if not player:canCast(1, 1, 0) then return end
	if player.magic < magicCost then notEnoughMP(player) return end
		
	player:sendAction(6, 20)
	player:setAether("set_trap", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:addNPC("set_trap", player.m, player.x, player.y, 313, 60000, player.ID)
	player:sendMinitext("You cast Set Trap.")
	addSpotTrap(player, player.m, player.x, player.y)
end,

click = function(block, npc)

	local duration = 5000
	local owner = npc:getBlock(npc.owner)
	
	if owner == nil or block:hasDuration("set_trap") then return end
	
	if (block.blType == BL_MOB) then
		block:playSound(33)
		block:sendAnimation(379, 0)
		block:setDuration("set_trap", duration, owner.ID)
		removeTrap(npc)
	elseif (block.blType == BL_PC and owner:canPK(block)) then
		block:playSound(33)
		block:sendAnimation(379, 0)
		block:setDuration("set_trap", duration, owner.ID)
		block:sendMinitext("You have been pierced by trap.")
		removeTrap(npc)
	end
end,

endAction = function(npc, owner) removeTrap(npc) end,

while_cast = function(block, caster)
	local damage = 1000
	local threat
	
	block.attacker = caster.ID
	
	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end
	
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
end,

requirements = function(player)
	
	local txt
	txt = "- 2 Rabbit Meat \n"
	txt = txt.."- 1 Banana \n"
	txt = txt.."- 500 Coins \n"
	
	local level = 26
	local items = {43, 18144, 0}
	local amounts = {2, 1, 500}
	local desc = {"Set a Poison Trap", "To learn this spell you must to sacriface\n"..txt..""}
	return level, item, amounts, desc
end
}