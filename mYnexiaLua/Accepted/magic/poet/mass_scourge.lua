mass_scourge = {

cast = function(player)

	local mob = player:getObjectsInArea(BL_MOB)
	local pc = player:getObjectsInArea(BL_PC)
	local magicCost = 5000
	
	if not player:canCast(1,1,0) then return end
	if player.magic < magicCost then notEnoughMP(player, npc) return end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setAether("mass_scourge", 120000)
	
	if #mob > 0 then
		for i = 1, #mob do
			if distanceSquare(player, mob[i], 7) then
				if not mob[i]:hasDuration("scourge") then
					mob[i].attacker = player.ID
					mob[i].target = player.ID
					mob[i]:sendAnimation(39)
					mob[i]:setDuration("scourge", 60000)
					player:playSound(79)
				end
			end
		end
	elseif #pc > 0 then
		for i = 1, #pc do
			if distanceSquare(player, pc[i], 7) then
				if pc[i].state ~= 1 and player:canPK(pc[i]) then
					if not pc[i]:hasDuration("scourge") then
						if pc[i].ID ~= player.ID then
							pc[i].attacker = player.ID
							pc[i]:sendAnimation(39)
							pc[i]:setDuration("scourge", 60000)
							player:playSound(79)
							pc[i]:sendMinitext(player.name.." cast scourge on you")
						end
					end
				end
			end
		end
	end
	player:sendMinitext("You cast Mass scourge")
end
}
					