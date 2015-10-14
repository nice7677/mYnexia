


vortex_strike = {

cast = function(player, target)

	local armor = player:getEquippedItem(4)
	local helm = player:getEquippedItem(6)
	local left = player:getEquippedItem(7)
	local right = player:getEquippedItem(8)
	local left2 = player:getEquippedItem(9)
	local right2 = player:getEquippedItem(10)
	local magicCost = 3000
	
	if not player:canCast(1,1,0) then anim(player) return end
	if player.magic < magicCost then notEnoughMP(player) return end
	
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendAction(6, 20)
	player:sendMinitext("You cast Vortex Strike")
	
	if player.baseClass == 3 then
		player:talk(2, "test")
		return
	end	
	
	if player.baseClass == 4 then
		vortex_strike.poet(player, target)
		return
	end

	
end,

poet = function(player, target)
	
	player:playSound(62)
	animationAround(target, 358)
	player:addNPC("vortex_strike", target.m, target.x, target.y, 1000, 20000, player.ID)
end,

rogue = function(player, target)
	


end,
	



action = function(npc, caster)

	local damage = caster.magic*.1 + math.random(100)
	local pc = npc:getObjectsInArea(BL_PC)
	local mob = npc:getObjectsInArea(BL_MOB)
	
	animationAround(npc, 132)
	if #pc > 0 then
		for i = 1, #pc do
			pc[i].attacker = caster.ID
			if distanceSquare(npc, pc[i], 2) and pc[i].state ~= 1 then
				if caster:canPK(pc[i]) and pc[i].ID ~= caster	.ID then
					pc[i]:removeHealthExtend(damage, 1,1,1,1,0)
				else
					addHealth(pc[i], damage)
				end
			end
		end
	end
	if #mob > 0 then
		for i = 1, #mob do
			mob[i].attacker = caster.ID
			if distanceSquare(npc, mob[i], 2) then
				mob[i]:removeHealthExtend(damage, 1,1,1,1,0)
			end
		end
	end
end,
	
endAction = function(block)

	block:delete()
end
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	